#
#    Copyright 2015 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
class plugin_emc_vnx::controller {

  include plugin_emc_vnx::common
  include ::cinder::params

  $plugin_settings = hiera('emc_vnx')

  package {$::plugin_emc_vnx::params::navicli_package_name:
    ensure => present,
  }

  if $::cinder::params::volume_package {
    package { $::cinder::params::volume_package:
      ensure => present,
    }
    Package[$::cinder::params::volume_package] -> Cinder_config<||>
  }

  case $plugin_settings['emc_driver'] {
    FC: { cinder_config {
            'DEFAULT/volume_driver': value => 'cinder.volume.drivers.emc.emc_cli_fc.EMCCLIFCDriver';
          }
        }
    ISCSI: { cinder_config {
            'DEFAULT/volume_driver': value => 'cinder.volume.drivers.emc.emc_cli_iscsi.EMCCLIISCSIDriver';
          }
        }
    default: { cinder_config {
            'DEFAULT/volume_driver': value => 'cinder.volume.drivers.emc.emc_cli_iscsi.EMCCLIISCSIDriver';
          }
        }
  }

  cinder_config {
    'DEFAULT/san_ip':                           value => $plugin_settings['emc_sp_a_ip'];
    'DEFAULT/san_secondary_ip':                 value => $plugin_settings['emc_sp_b_ip'];
    'DEFAULT/san_login':                        value => $plugin_settings['emc_username'];
    'DEFAULT/san_password':                     value => $plugin_settings['emc_password'];
    'DEFAULT/storage_vnx_authentication_type':  value => 'global';
    'DEFAULT/destroy_empty_storage_group':      value => 'False';
    'DEFAULT/attach_detach_batch_interval':     value => '-1';
    'DEFAULT/naviseccli_path':                  value => '/opt/Navisphere/bin/naviseccli';
    'DEFAULT/initiator_auto_registration':      value => 'True';
    'DEFAULT/default_timeout':                  value => '10';
    'DEFAULT/use_multipath_for_image_xfer':     value => 'True';
    'DEFAULT/host':                             value => 'cinder';
  }

  if $plugin_settings['emc_pool_name'] {
    cinder_config {
      'DEFAULT/storage_vnx_pool_name':          value => $plugin_settings['emc_pool_name'];
    }
  }

  Cinder_config<||> ~> Service<| title == 'cinder_volume' |>

  file {'cinder-volume-agent-ocf':
    path   =>'/usr/lib/ocf/resource.d/fuel/cinder-volume',
    mode   => '0755',
    owner  => root,
    group  => root,
    source => 'puppet:///modules/plugin_emc_vnx/ocf/cinder-volume',
  }

  service { 'cinder_volume-init_stopped':
    ensure     => stopped,
    name       => $::cinder::params::volume_service,
    enable     => false,
    hasstatus  => true,
    hasrestart => true,
  }

  service { 'cinder_volume':
    ensure     => running,
    enable     => true,
    name       => "p_${::cinder::params::volume_service}",
    provider   => 'pacemaker',
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$::plugin_emc_vnx::params::navicli_package_name],
  }


  Service<| title == 'cinder_volume-init_stopped' |> -> Service<| title == 'cinder_volume' |>
  File<| title == 'cinder-volume-agent-ocf' |> ~>  Service<| title == 'cinder_volume' |>
}

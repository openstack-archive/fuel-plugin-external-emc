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
class plugin_emc_vnx::cinder_volume {

  include ::cinder::params

  $is_primary_controller = hiera('role') ? { 'primary-controller'=>true, default=>false }

  Cinder_config<||> ~> Service['cinder_volume']

  if $::cinder::params::volume_package {
    Package['cinder-volume'] -> Cinder_config<||>
    Package['cinder-volume'] ~> Service['cinder_volume']
    package { 'cinder-volume':
      ensure => present,
      name   => $::cinder::params::volume_package,
    }
  }

  # set the same value for host parameter on all cinder-volume instances
  cinder_config {
    'DEFAULT/host':     value => 'cinder';
  }

  # OCF script for pacemaker
  # and his dependences
  file {'cinder-volume-agent-ocf':
    path   =>'/usr/lib/ocf/resource.d/fuel/cinder-volume',
    mode   => '0755',
    owner  => root,
    group  => root,
    source => 'puppet:///modules/plugin_emc_vnx/ocf/cinder-volume',
  }

  if $::cinder::params::volume_package {
    Package[$::cinder::params::volume_package] ->
      File['cinder-volume-agent-ocf']
  }

  if $is_primary_controller {
    cs_resource { "p_${::cinder::params::volume_service}":
      ensure          => present,
      primitive_class => 'ocf',
      provided_by     => 'fuel',
      primitive_type  => 'cinder-volume',
      metadata        => { 'resource-stickiness' => '100' },
      parameters      => {
        'amqp_server_port' => hiera('amqp_port'),
        'multibackend'     => true,
      },
      operations      => {
        'monitor'  => {
          'interval' => '20',
          'timeout'  => '10'
        }
        ,
        'start'    => {
          'timeout' => '60'
        }
        ,
        'stop'     => {
          'timeout' => '60'
        }
      },
    }

    Service['cinder_volume-init_stopped'] ->
      Cs_resource["p_${::cinder::params::volume_service}"] ->
      Service['cinder_volume']

    File['cinder-volume-agent-ocf'] ->
      Cs_resource["p_${::cinder::params::volume_service}"]

  } else {
    # Non-primary controller:

    Service['cinder_volume-init_stopped'] -> Service['cinder_volume']
    File['cinder-volume-agent-ocf'] -> Service['cinder_volume']

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
    name       => "p_${::cinder::params::volume_service}",
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => 'pacemaker',
  }

}

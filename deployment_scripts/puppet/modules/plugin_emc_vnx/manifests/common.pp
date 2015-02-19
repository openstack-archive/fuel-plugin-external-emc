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
class plugin_emc_vnx::common {

  include plugin_emc_vnx::params

  package {$plugin_emc_vnx::params::iscsi_package_name:
    ensure => 'installed'
  }
  case $::osfamily {
    'Debian': {
      service {$plugin_emc_vnx::params::iscsi_service_name:
        ensure     => 'running',
        enable     => true,
        hasrestart => true,
        require    => Package[$plugin_emc_vnx::params::iscsi_package_name],
      }
      file {'iscsid.conf':
        path    => '/etc/iscsi/iscsid.conf',
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => 'puppet:///modules/plugin_emc_vnx/iscsid.conf',
        require => Package[$plugin_emc_vnx::params::iscsi_package_name],
        notify  => Service[$plugin_emc_vnx::params::iscsi_service_name],
      }
    }
    'RedHat': {
      file {'iscsid.conf':
        path    => '/etc/iscsi/iscsid.conf',
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => 'puppet:///modules/plugin_emc_vnx/iscsid.conf-centos',
        require => Package[$plugin_emc_vnx::params::iscsi_package_name],
      }
    }
    default: {
      fail("unsuported osfamily ${::osfamily}, currently Debian and Redhat are the only supported platforms")
    }
  }
  package {$plugin_emc_vnx::params::multipath_package_name:
    ensure => 'installed'
  }
  service {$plugin_emc_vnx::params::multipath_service_name:
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
    status     => 'pgrep multipathd',
    require    => Package[$plugin_emc_vnx::params::multipath_package_name],
  }
  file {'multipath.conf':
    path    => '/etc/multipath.conf',
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/plugin_emc_vnx/multipath.conf',
    require => Package[$plugin_emc_vnx::params::multipath_package_name],
    notify  => Service[$plugin_emc_vnx::params::multipath_service_name],
  }

}

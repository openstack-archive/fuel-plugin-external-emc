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
class plugin_emc_vnx::params {

  case $::osfamily {
    'Debian': {
      $navicli_package_name = 'navicli-linux-64-x86-en-us'
      $iscsi_package_name = 'open-iscsi'
      $iscsi_service_name = 'open-iscsi'
      $multipath_package_name = 'multipath-tools'
      $multipath_service_name = 'multipath-tools'
    }
    'RedHat': {
      $navicli_package_name = 'NaviCLI-Linux-64-x86-en_US'
      $iscsi_package_name = 'iscsi-initiator-utils'
      $iscsi_service_name = false
      $multipath_package_name = 'device-mapper-multipath'
      $multipath_service_name = 'multipathd'
    }
    default: {
      fail("unsuported osfamily ${::osfamily}, currently Debian and Redhat are the only supported platforms")
    }
  }
}

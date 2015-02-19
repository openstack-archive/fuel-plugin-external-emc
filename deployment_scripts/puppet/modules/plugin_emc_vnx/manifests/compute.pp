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
class plugin_emc_vnx::compute {

  include plugin_emc_vnx::common
  include ::nova::params

  service { 'nova-compute':
    ensure     => 'running',
    name       => $::nova::params::compute_service_name,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  nova_config { 'libvirt/iscsi_use_multipath': value => 'True' }

  Nova_config<||> ~> Service['nova-compute']

}

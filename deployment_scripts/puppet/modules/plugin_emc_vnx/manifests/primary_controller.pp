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
class plugin_emc_vnx::primary_controller {

  include plugin_emc_vnx::controller


  cluster::corosync::cs_service { 'cinder-volume':
    require         =>  File['cinder-volume-agent-ocf'],
    ocf_script      =>  'cinder-volume',
    csr_parameters  =>  {
      'amqp_server_port' => hiera('amqp_port'),
      'multibackend'     => true,
    },
    csr_metadata    => { 'resource-stickiness' => '100' },
    csr_mon_intr    => '20',
    csr_mon_timeout => '10',
    csr_timeout     => '60',
    package_name    => 'cinder-volume',
    service_title   => 'cinder-volume',
    service_name    => 'cinder-volume',
  }

}

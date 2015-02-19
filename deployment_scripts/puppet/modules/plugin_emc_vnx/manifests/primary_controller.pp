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

  cs_resource { "p_${::cinder::params::volume_service}":
    ensure          => present,
    require         => File['cinder-volume-agent-ocf'],
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

}

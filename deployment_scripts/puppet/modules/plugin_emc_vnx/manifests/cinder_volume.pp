class plugin_emc_vnx::cinder_volume (
  $is_primary_controller = false,
  $ha                    = false,
  # the port number is copied from osnailyfacter/manifests/cluster_ha.pp:227
  $rabbitmq_bind_port    = '5673',
) {

  include ::cinder::params

  Cinder_config<||> ~> Service['cinder_volume']

  if $::cinder::params::volume_package {
    Package['cinder-volume'] -> Cinder_config<||>
    Package['cinder-volume'] ~> Service['cinder_volume']
    package { 'cinder-volume':
      ensure => present,
      name   => $::cinder::params::volume_package,
    }
  }

  if $ha {

    # set the same value for host parameter on all cinder-volume instances
    cinder_config {
      'DEFAULT/host':     value => 'cinder';
    }

    # OCF script for pacemaker
    # and his dependences
    file {'cinder-volume-agent-ocf':
      path   =>'/usr/lib/ocf/resource.d/mirantis/cinder-volume',
      mode   => '0755',
      owner  => root,
      group  => root,
      source => "puppet:///modules/plugin_emc_vnx/ocf/cinder-volume",
    }

    if $::cinder::params::volume_package {
      Package[$::cinder::params::volume_package] ->
        File['cinder-volume-agent-ocf']
    }

    if $is_primary_controller {
      cs_resource { "p_${::cinder::params::volume_service}":
        ensure          => present,
        primitive_class => 'ocf',
        provided_by     => 'mirantis',
        primitive_type  => 'cinder-volume',
        metadata        => { 'resource-stickiness' => '100' },
        parameters      => {
          'amqp_server_port' => $rabbitmq_bind_port,
          'multibackend'     => 'true',
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
      name       => $::cinder::params::volume_service,
      enable     => false,
      ensure     => stopped,
      hasstatus  => true,
      hasrestart => true,
    }

    service { 'cinder_volume':
      name       => "p_${::cinder::params::volume_service}",
      enable     => true,
      ensure     => running,
      hasstatus  => true,
      hasrestart => true,
      provider   => 'pacemaker',
    }

  } else {
    # No pacemaker use:
    service { 'cinder_volume':
      ensure     => running,
      name       => $::cinder::params::volume_service,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}

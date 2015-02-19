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

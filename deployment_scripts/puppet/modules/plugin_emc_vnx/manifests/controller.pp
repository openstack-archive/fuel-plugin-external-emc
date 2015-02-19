class plugin_emc_vnx::controller {

  include plugin_emc_vnx::common
  include plugin_emc_vnx::cinder_volume

  package {$::plugin_emc_vnx::params::navicli_package_name:
    ensure => installed,
  }

  $plugin_settings = hiera('emc_vnx')

  cinder_config {
    'DEFAULT/volume_driver':                    value => 'cinder.volume.drivers.emc.emc_cli_iscsi.EMCCLIISCSIDriver';
    'DEFAULT/san_ip':                           value => $plugin_settings['emc_sp_a_ip'];
    'DEFAULT/san_secondary_ip':                 value => $plugin_settings['emc_sp_b_ip'];
    'DEFAULT/san_login':                        value => $plugin_settings['emc_username'];
    'DEFAULT/san_password':                     value => $plugin_settings['emc_password'];
    'DEFAULT/storage_vnx_authentication_type':  value => 'global';
    'DEFAULT/destroy_empty_storage_group':      value => 'True';
    'DEFAULT/attach_detach_batch_interval':     value => '-1';
    'DEFAULT/naviseccli_path':                  value => '/opt/Navisphere/bin/naviseccli';
    'DEFAULT/initiator_auto_registration':      value => 'True';
    'DEFAULT/default_timeout':                  value => '10';
    'DEFAULT/use_multipath_for_image_xfer':     value => 'True';
  }


  if $plugin_settings['emc_pool_name'] {
    cinder_config {
      'DEFAULT/storage_vnx_pool_name':          value => $plugin_settings['emc_pool_name'];
    }
  }

}

class plugin_emc_vnx {

  case $::fuel_settings['role'] {

    'primary-controller', 'controller': { 
      include plugin_emc_vnx::controller
    }

    'compute': {
      include plugin_emc_vnx::compute
    }

  }

}

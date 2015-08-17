==================
Installation Guide
==================

EMC VNX backend configuration
============================================

Before starting a deployment, you have to preconfigure EMC VNX array and connect it 
properly to the environment. Both EMC SP IPs and all iSCSI ports should be available 
over storage interface from OpenStack nodes. To learn more about EMC VNX configuration,
see `The official EMC VNX series documentation <https://mydocuments.emc.com/DynDispatcher?prod=VNX&page=ConfigGroups_VNX>`_

EMC VNX configuration checklist:

+------------------------------------+-------------------------+
|Item to confirm                     |  Status (tick if done)  |
+====================================+=========================+
|Create username/password	     |			       |
+------------------------------------+-------------------------+
|Create at least one storage pool    |    	               |
+------------------------------------+-------------------------+
|Configure network: 		     |			       |
|   - for A and B Service Processor  |			       |
|   - for all iSCSI ports	     |			       |
+------------------------------------+-------------------------+


EMC VNX plugin installation
============================================

#. Download the plugin from the `Fuel Plugins Catalog <https://www.mirantis.com/products/
   openstack-drivers-and-plugins/fuel-plugins/>`_. 

#. Copy the plugin on already installed Fuel Master node. If you do not have the Fuel Master node yet, see `Quick Start Guide
   <https://software.mirantis.com/quick-start/>`_::

    # scp emc_vnx-2.0-2.0.0-1.noarch.rpm root@<the_Fuel_Master_node_IP>:/tmp

#. Log into the Fuel Master node. Install the plugin::

    # cd /tmp
    # fuel plugins --install emc_vnx-2.0-2.0.0-1.noarch.rpm

#. Check if the plugin was installed successfully::

    # fuel plugins
    id | name    | version | package_version
    ---|---------|---------|----------------
    1  | emc_vnx | 2.0.0   | 2.0.0  


EMC VNX plugin removal
============================================

#. Delete all Environments in which EMC VNX plugin has been enabled.

#. Uninstall the plugin:
   
    # fuel plugins --remove emc_vnx==2.0.0

#. Check if the plugin was uninstalled successfully::
   
    # fuel plugins
    id | name                      | version  | package_version
    ---|---------------------------|----------|------

Uninstall EMC VNX plugin
========================

To uninstall the EMC VNX plugin, complete the following steps:

#. Using the Fuel CLI, delete all the Mirantis OpenStack environments in
   which the EMC VNX plugin has been enabled:

   .. code-block:: console

    # fuel --env <ENV_ID> env delete

#. Uninstall the plugin:

   .. code-block:: console

    # fuel plugins --remove emc_vnx==4.0.0

#. Verify whether the VMware DVS plugin was uninstalled successfully:

   .. code-block:: console

     # fuel plugins

   The EMC VNX plugin should not appear in the output list.

Uninstall Zabbix plugin
=======================

To uninstall the Zabbix plugin, complete the following steps:

#. Using the Fuel CLI, delete all the Mirantis OpenStack environments in
   which the Zabbix plugin has been enabled:

   .. code-block:: console

    # fuel --env <ENV_ID> env delete

#. Uninstall the plugin:

   .. code-block:: console

    # fuel plugins --remove zabbix_monitoring==2.5.0

#. Verify whether the Zabbix plugin was uninstalled successfully:

   .. code-block:: console

    # fuel plugins

   The Zabbix plugin should not appear in the output list.

.. raw:: latex

   \pagebreak
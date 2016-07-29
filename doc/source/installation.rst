.. _install:

Requirements
============

The EMC VNX plugin for Fuel has the following requirements:

.. list-table::
   :widths: 10 25
   :header-rows: 1

   * - Requirement
     - Version
   * - Fuel
     - 8.0
   * - EMC VNX array
     - VNX Operational Environment for Block 5.32 or higher

.. seealso::
 * :ref:`limit`
 * :ref:`zabbix`

.. _prereqs:

Prerequisites
=============

Before you install and start using the Fuel EMC VNX plugin, complete the
following steps:

#. Install and set up `Fuel 8.0 for Liberty <https://www.mirantis.com/software/mirantis-openstack/releases/>`_.
   For details, see `Fuel Installation Guide <https://docs.mirantis.com/openstack/fuel/fuel-8.0/fuel-install-guide.html>`_.
#. Activate the VNX Snapshot and Thin Provisioning license.
#. Configure and deploy the EMC VNX array.
#. Verify that the EMC VNX array is reachable through one of the Mirantis
   OpenStack networks. Both EMC SP IPs and all iSCSI ports should be available
   over the storage interface from OpenStack nodes.
#. Configure the EMC VNX back end. For details, see
   `Openstack Configuration Reference <http://docs.openstack.org/mitaka/config-reference/block-storage/drivers/emc-vnx-driver.html>`_.

For details on EMC VNX configuration, see the
`official EMC VNX series documentation <https://mydocuments.emc.com/requestMyDoc.jsp>`_.

EMC VNX configuration checklist:

+------------------------------------+-------------------------+
|Item to confirm                     |  Status (tick if done)  |
+====================================+=========================+
|Create username/password.           |                         |
+------------------------------------+-------------------------+
|Create at least one storage pool.   |                         |
+------------------------------------+-------------------------+
|Configure network:                  |                         |
|   - for A and B Service Processor  |                         |
|   - for all iSCSI ports            |                         |
+------------------------------------+-------------------------+
| Configure the EMC VNX back end.    |                         |
+------------------------------------+-------------------------+

Install the plugin
==================

Before you proceed with the Fuel EMC VNX plugin installation, verify that
you have completed the :ref:`prereqs` steps.

To install the Fuel EMC VNX plugin:

#. Go to the
   `Fuel plugins' catalog <https://www.mirantis.com/validated-solution-integrations/fuel-plugins>`_.

#. From the :guilabel:`Filter` drop-down menu, select the Mirantis OpenStack
   version 8.0 and the :guilabel:`STORAGE` category.

#. Find Fuel EMC VNX plugin in the plugins' list and download its ``.rpm``
   file.

#. Copy the ``.rpm`` file to the Fuel Master node:

   .. code-block:: console

    # scp emc_vnx-3.0-3.0.0-1.noarch.rpm root@<FUEL_MASTER_NODE_IP>:/tmp

#. Log into the Fuel Master node CLI as root.

#. Install the plugin:

   .. code-block:: console

    # cd /tmp
    # fuel plugins --install emc_vnx-3.0-3.0.0-1.noarch.rpm

#. Verify that the plugin was installed successfully:

   .. code-block:: console

    # fuel plugins

    id | name    | version | package_version
    ---|---------|---------|----------------
    1  | emc_vnx | 3.0.0   | 3.0.0

#. Proceed to :ref:`configure_env`.

.. raw:: latex

   \pagebreak

.. _configure_env:

Configure EMC VNX plugin for an environment
===========================================

To configure the EMC VNX plugin during a Mirantis OpenStack environment
deployment:

#. Using the Fuel web UI,
   `create a new environment <https://docs.mirantis.com/openstack/fuel/fuel-8.0/fuel-user-guide.html#create-a-new-openstack-environment>`_.

   #. In the :guilabel:`Storage Backends` tab, leave the default
      :guilabel:`LVM over iSCSI` back end for Cinder.
   #. Do not add the :guilabel:`Cinder` role to any node, since all the Cinder
      services will be run on controller nodes.

#. In the Fuel web UI, open your new environment and click
   :menuselection:`Settings -> Other`.

#. Select the :guilabel:`EMX VNX driver for Cinder` check box:

   .. image:: images/settings.png
      :width: 90%

#. Fill in the :guilabel:`EMX VNX driver for Cinder` form fields:

   .. list-table::
      :header-rows: 1

      * - Field
        - Description/Comment
      * - Username and password 
        - Access credentials configured on EMC VNX.
      * - SP A and B IPs
        - IP addresses of the EMC VNX Service Processors.
      * - Pool name (optional)
        - The name of the EMC VNX storage pool on which all Cinder volumes
          will be created. The provided storage pool must be available on
          EMC VNX. If pool name is not provided, then the EMC VNX driver will
          use a random storage pool available on EMC VNX.

#. Make additional `configuration adjustments <https://docs.mirantis.com/openstack/fuel/fuel-8.0/fuel-user-guide.html#configure-your-environment>`_
   as required.

#. Proceed to the `environment deployment <https://docs.mirantis.com/openstack/fuel/fuel-8.0/fuel-user-guide.html#deploy-an-openstack-environment>`_.
#. Complete the :ref:`environment verification steps <verify>`.

.. raw:: latex

   \pagebreak

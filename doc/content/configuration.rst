============================
EMC VNX plugin configuration
============================

1. Create an environment with the default backend for Cinder. Do not add Cinder 
   role to any node, because all Cinder services will be run on Controllers.
   For more information about environment creation, see `Mirantis OpenStack
   User Guide - create a new environment <http://docs.mirantis.com/openstack
   /fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_.

2. Open Settings tab of the Fuel web UI and scroll the page down. Select the
   plugin checkbox and fill in form fields:

   .. image:: images/settings.png
      :width: 50%

================================== ===============
Field                              Comment
================================== ===============
Username/password                  Access credentials configured on EMC VNX.
SP A/B IP                          IP addresses of the EMC VNX Service
                                   Processors.
Pool name (optional)               The name of the EMC VNX storage pool on
                                   which all Cinder volumes will be created.
                                   The provided storage pool must be available
                                   on EMC VNX. If pool name is not provided,
                                   then EMC VNX driver will use a random
                                   storage pool available on EMC VNX. You can
                                   also use a Volume Type OpenStack feature to
                                   create a volume on a specific storage pool.
                                   For more information, see `Multiple Pools
                                   Support <https://github.com/emc-openstack
                                   /vnx-direct-driver/blob/master
                                   /README_ISCSI.md#multiple-pools-support>`_.
================================== ===============

3. Adjust other environment settings to your requirements and deploy the
   environment.  For more information, see `Mirantis OpenStack User Guide -
   deploy changes <http://docs.mirantis.com/openstack/fuel/fuel-7.0
   /user-guide.html#deploy-changes>`_.

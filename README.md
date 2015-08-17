EMC VNX Plugin for Fuel
=======================

EMC VNX plugin
--------------

EMC VNX plugin for Fuel extends Mirantis OpenStack functionality by adding
support for EMC VNX arrays in Cinder using iSCSI protocol. It replaces Cinder
LVM driver which is the default volume backend that uses local volumes
managed by LVM.

Requirements
------------

| Requirement                      | Version/Comment |
|:---------------------------------|:----------------|
| Mirantis OpenStack compatibility | >= 7.0          |

Limitations
-----------

Since only one storage network is available in Fuel 6.x on OpenStack nodes,
multipath will bind all storage paths from EMC on one network interface.
In case this NIC fails, the communication with storage is lost.

Installation Guide
==================


EMC VNX configuration
---------------------

Before starting a deployment you have to preconfigure EMC VNX array and connect
it properly to the environment. Both EMC SP IPs and all iSCSI ports should be
available over storage interface from OpenStack nodes. To learn more about
EMC VNX configuration, see
[the official EMC VNX series documentation](https://mydocuments.emc.com/DynDispatcher?prod=VNX&page=ConfigGroups_VNX)

EMC VNX configuration checklist:
1. create username/password
2. create at least one storage pool
3. configure network for A and B Service Processors
4. configure network for all iSCSI ports

EMC VNX plugin installation
---------------------------

To install EMC VNX plugin, follow these steps:

1. Download the plugin from
    [Fuel Plugins Catalog](https://software.mirantis.com/fuel-plugins)

2. Copy the plugin on already installed Fuel Master node; ssh can be used for
    that. If you do not have the Fuel Master node yet, see
    [Quick Start Guide](https://software.mirantis.com/quick-start/):

        # scp emc_vnx-2.0-2.0.0-0.noarch.rpm root@<Fuel_master_ip>:/tmp

3. Log into the Fuel Master node. Install the plugin:

        # cd /tmp
        # fuel plugins --install emc_vnx-2.0-2.0.0-0.noarch.rpm

4. Check if the plugin was installed successfully:

        # fuel plugins
        id | name    | version | package_version
        ---|---------|---------|----------------
        1  | emc_vnx | 2.0.0   | 2.0.0

EMC VNX plugin configuration
----------------------------

1. Create an environment with the default backend for Cinder.
2. Enable the plugin on the Settings tab of the Fuel web UI and fill in form
    fields:
   * username/password - access credentials configured on EMC VNX
   * SP A/B IP - IP addresses of the EMC VNX Service Processors
   * pool name (optional) - a name of the EMC VNX storage pool on which all
    Cinder volumes will be created. Provided storage pool must be available on
    EMC VNX. If pool name is not provided then EMC VNX driver will use a random
    storage pool available on EMC VNX. You can also use a Volume Type OpenStack
    feature to create a volume on a specific storage pool.
    For more information, see
    [Multiple pools support](https://github.com/emc-openstack/vnx-direct-driver
    /blob/master/README_ISCSI.md#multiple-pools-support)
3. Deploy the environment without a Cinder node. All required Cinder services
    are run on Controller nodes.

Release Notes
-------------

This is the first release of the plugin.

Contributors
------------

Dmitry Klenov <dklenov@mirantis.com> (PM)
Szymon Bańka <sbanka@mirantis.com> (developer)
Piotr Misiak <pmisiak@mirantis.com> (developer)
Dmitry Kalashnik <dkalashnik@mirantis.com> (QA engineer)
Maciej Relewicz <mrelewicz@mirantis.com> (developer)

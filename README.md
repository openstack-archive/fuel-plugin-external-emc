EMC VNX Plugin for Fuel
=======================

EMC VNX plugin
--------------

EMC VNX plugin for Fuel extends MOS functionality by adding support for EMC VNX
arrays in Cinder using iSCSI protocol. It replaces Cinder LVM driver which is
the default volume backend that uses local volumes managed by LVM.

Requirements
------------

Requirement | Version/Comment
--- | --- 
Mirantis OpenStack compatility | 6.0
EMC VNX array is deployed and configured. |
EMC VNX array is reachable via one of the Mirantis OpenStack networks. |

Limitations
-----------

Since only one storage network is available in Fuel 6.x on Openstack nodes
multipath will bind all storage paths from EMC on one network interface.
In case this NIC fails communication with storage is lost.

Installation Guide
==================


EMC VNX configuration
---------------------

Before starting a deployment you have to preconfigure EMC VNX array and connect
it properly to the environment (detailed EMC preconfiguration is not a part of
this document). Both EMC SP IPs and all iSCSI ports should be available over
storage interface from Openstack nodes.

EMC VNX configuration checklist:
1. create username/password
2. create at least one storage pool
3. configure network for A and B Service Processors
4. configure network for all iSCSI ports

EMC VNX plugin installation
---------------------------

To install EMC VNXtran plugin, follow these steps:

1. Download the plugin from https://software.mirantis.com/fuel-plugins

2. Copy the plugin on already installed Fuel Master node; ssh can be used for
    that. If you do not have the Fuel Master node yet, see Running Mirantis
    OpenStack on VirtualBox:
   
   `scp emc_vnx-1.0.0.fp root@:master_node_ip:/tmp`

3. Install the plugin:

   `fuel plugins --install emc_vnx-1.0.0.fp`
   
4. Check if plugin was installed successfully:

   ```
   fuel plugins
   id | name    | version | package_version
   ---|---------|---------|----------------
   1  | emc_vnx | 1.0.0   | 1.0.0
   ```

EMC VNX plugin configuration
----------------------------

1. Create an environment with the default backend for Cinder.
2. Enable the plugin on the Settings tab of the Fuel UI and fill in form
    fields:
   * username/password - access credentials configured on EMC VNX
   * SP A/B IP - IP addresses of the EMC VNX Service Processors
   * pool name (optional) - a name of the EMC VNX storage pool on which all
    Cinder volumes will be created. Provided storage pool must be available on
    EMC VNX. If pool name is not provided then EMC VNX driver will use a random
    storage pool available on EMC VNX. You can also use a Volume Type OpenStack
    feature to create a volume on a specific storage pool. More informations
    here: https://github.com/emc-openstack/vnx-direct-driver/blob/master/README_ISCSI.md#multiple-pools-support
3. Deploy the environment without a Cinder node. All required Cinder services
    are run on Controller nodes.


User Guide
==========


Known issues
------------


Release Notes
-------------


Contributors
------------

Szymon Bańka <sbanka@mirantis.com><br>
Piotr Misiak <pmisiak@mirantis.com>
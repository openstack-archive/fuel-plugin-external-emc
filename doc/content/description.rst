===================================================
Guide to the EMC VNX Plugin for Fuel
===================================================

EMC VNX plugin for Fuel extends Mirantis OpenStack functionality by adding
support for EMC VNX arrays in Cinder using iSCSI protocol. It replaces Cinder
LVM driver which is the default volume backend that uses local volumes managed
by LVM. Enabling EMC VNX plugin in Mirantis OpenStack means that all Cinder
services are run on Controller nodes.

Requirements
============

+------------------------------------+----------------------------------------+
|Requirement                         | Version/Comment                        |
+====================================+========================================+
|Fuel                                | 7.0 and higher                         |
+------------------------------------+----------------------------------------+
|EMC VNX array                       | It should be configured and deployed.  |
|                                    | It should be reachable via one         |
|                                    | of the Mirantis OpenStack networks.    |
+------------------------------------+----------------------------------------+


Limitations
============

#. Since only one storage network is available in Fuel 7.x on OpenStack nodes,
   multipath will bind all storage paths from EMC on one network interface.
   In case this NIC fails, the communication with storage is lost.

#. Fibre Channel driver is not supported.

#. Emc plugin cannot be used together with cinder role and/or options 'Cinder LVM over iSCSI for volumes', 'Ceph RBD for volumes (Cinder)'.

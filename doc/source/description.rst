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

+-----------------+-----------------------------------------------------------+
|Requirement      | Version/Comment                                           |
+=================+===========================================================+
|Fuel             | 8.0                                                       |
+-----------------+-----------------------------------------------------------+
|EMC VNX array    | #. VNX Operational Environment for Block version 5.32     |
|                 |    or higher.                                             |
|                 | #. VNX Snapshot and Thin Provisioning license should be   |
|                 |    activated for VNX.                                     |
|                 | #. Array should be configured and deployed.               |
|                 | #. Array should be reachable via one of the Mirantis      |
|                 |    OpenStack networks.                                    |
+-----------------+-----------------------------------------------------------+

Limitations
============

#. Since only one storage network is available in Fuel 8.x on OpenStack nodes,
   multipath will bind all storage paths from EMC on one network interface.
   In case this NIC fails, the communication with storage is lost.

#. Fibre Channel driver is not supported.

#. EMC VNX plugin cannot be used together with cinder role and/or options
   'Cinder LVM over iSCSI for volumes', 'Ceph RBD for volumes (Cinder)'.

Compatible monitoring plugins
=============================

#. zabbix_monitoring-2.5-2.5.0-1.noarch.rpm
#. zabbix_snmptrapd-1.0-1.0.1-1.noarch.rpm
#. zabbix_monitoring_extreme_networks-1.0-1.0.1-1.noarch.rpm
#. zabbix_monitoring_emc-1.0-1.0.1-1.noarch.rpm

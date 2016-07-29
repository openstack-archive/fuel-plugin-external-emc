.. _limit:

Limitations
============

The EMC VNX plugin has the following limitations:

#. Since only one storage network is available in Fuel 8.x on OpenStack
   nodes, multipath will bind all storage paths from EMC on one network
   interface. In case this NIC fails, the communication with storage is
   lost.
#. EMC VNX plugin cannot be used together with Cinder role and/or the
   following OpenStack environment options:
   :guilabel:`Cinder LVM over iSCSI for volumes`,
   :guilabel:`Ceph RBD for volumes (Cinder)`.
#. Fibre Channel driver is not supported.
 

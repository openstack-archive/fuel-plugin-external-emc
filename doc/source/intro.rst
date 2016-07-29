Introduction
============

This documentation provides instructions for installing, configuring, and
using the Fuel EMC VNX plugin version 3.0.0.

The EMC VNX plugin for Fuel extends the Mirantis OpenStack functionality by
adding support for the EMC VNX arrays in Cinder using the iSCSI protocol. It
replaces Cinder LVM driver which is the default volume back end that uses
local volumes managed by LVM. Enabling EMC VNX plugin in Mirantis OpenStack
means that all the Cinder services are run on controller nodes.

Key terms and abbreviations
===========================

The table below lists the key terms and abbreviations that are used in this
document.

.. tabularcolumns:: |p{4cm}|p{12.5cm}|

====================== ================================================
**Term/abbreviation**  **Definition**
====================== ================================================
EMC VNX                Unified, hybrid-flash storage used for virtual
                       applications and cloud-environments.
Cinder                 OpenStack Block Storage
iSCSI                  Internet Small Computer System Interface. An
                       Internet Protocol (IP)-based storage networking
                       standard for linking data storage facilities.
                       By carrying SCSI commands over IP networks,
                       iSCSI is used to facilitate data transfers over
                       intranets and to manage storage over long
                       distances. iSCSI can be used to transmit data
                       over local area networks (LANs), wide area
                       networks (WANs), or the Internet and can enable
                       location-independent data storage and retrieval.
LVM                    A logical volume manager for the Linux kernel
                       that manages disk drives and similar
                       mass-storage devices.
LUN                    Logical unit number
====================== ================================================

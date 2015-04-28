..
 This work is licensed under the Apache License, Version 2.0.

 http://www.apache.org/licenses/LICENSE-2.0

==================================================
Fuel plugin for EMC VNX arrays as a Cinder backend
==================================================

EMC VNX plugin for Fuel extends Mirantis OpenStack functionality by adding
support for EMC VNX arrays in Cinder using iSCSI protocol.
It replaces Cinder LVM driver which is the default volume backend that uses
local volumes managed by LVM.

Problem description
===================

Currently, Fuel has no support for EMC VNX arrays as block storage for
OpenStack environments. EMC VNX plugin aims to provide support for it.

Proposed change
===============

Implement a Fuel plugin that will install and configure the EMC VNX driver for
Cinder on all Controller nodes. Cinder volume service will be managed
by Pacemaker/Corosync to provide HA. Having all Cinder services run
on controllers no additional Cinder node is required in environment.

Alternatives
------------

It might have been implemented as part of Fuel core but we decided to make it
as a plugin for several reasons:

* This isn't something that all operators may want to deploy.
* Any new additional functionality makes the project's testing more difficult,
  which is an additional risk for the Fuel release.

Data model impact
-----------------

None

REST API impact
---------------

None

Upgrade impact
--------------

None

Security impact
---------------

None

Notifications impact
--------------------

None

Other end user impact
---------------------

None

Performance Impact
------------------

The EMC VNX driver could be slow when it comes to EMC VNX array configuration.
All volume management commands (creating/deleting/attaching etc.) can take
longer than usual. For example, creation a volume from an image
(even very small like CirrOS) may take over 60 seconds.

Other deployer impact
---------------------

The deployer has to preconfigure an EMC VNX array before it can be used with
the plugin.

Developer impact
----------------

None

Implementation
==============

Plugin delivers packages with multipath daemon and EMC NaviSecCli (command line
toolkit for EMC VNX arrays management) because they are not included in
Mirantis OpenStack.
Plugin has three tasks. Each task per role. They are run in the following order:

* The first task installs and configures cinder-volume on Primary Controller.
* The second task installs and configures cinder-volume on Controller nodes.
* THe third task configures Nova on Compute nodes.

Cinder-volume service is installed on all Controller nodes and is managed by
Pacemaker. It runs in active/passive mode where only one instance is active.
Plugin installs a dedicated resource manager file (OCF) for this.
All instances of cinder-volume have the same “host” parameter in cinder.conf
file. This is required to achieve ability to manage all volumes in the
environment by any cinder-volume instance.
Plugin also installs multipathd daemon and iscsid daemon on all Controller
and Compute nodes and puts customized configuration files for them.
Finally, plugin enables multipath in Cinder and Nova config files.

Assignee(s)
-----------

| Dmitry Klenov <dklenov@mirantis.com> (PM)
| Piotr Misiak <pmisiak@mirantis.com> (developer)
| Szymon Bańka <sbanka@mirantis.com> (developer)
| Dmitry Kalashnik <dkalashnik@mirantis.com> (QA engineer)

Work Items
----------

* Implement the Fuel plugin.
* Implement the Puppet manifests.
* Testing.
* Write the documentation.

Dependencies
============

* Fuel 6.0 and higher.

Testing
=======

* Prepare a test plan.
* Test the plugin by deploying environments with all Fuel deployment modes.

Documentation Impact
====================

* Deployment Guide (how to install the storage backends, how to prepare an
  environment for installation, how to install the plugin, how to deploy an
  OpenStack environment with the plugin).
* User Guide (which features the plugin provides, how to use them in the
  deployed OpenStack environment).
* Test Plan.
* Test Report.


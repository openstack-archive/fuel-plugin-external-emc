.. _user:

Create a Cinder volume
======================

Once you deploy an OpenStack environment with the EMC VNX plugin, you can
start creating Cinder volumes. The following example shows how to create a
10 GB volume and attach it to a VM.

#. Login to a controller node.
#. Create a Cinder volume:

   .. code-block:: console

    # cinder create <VOLUME_SIZE>

   The output looks as follows:

   .. image:: images/create.png
      :width: 90%

#. Verify that the volume is created and is ready for use:

   .. code-block:: console

    # cinder list

   In the output, verify the ID and the ``available`` status of the volume
   (see the screenshot above).

#. Verify the volume on EMC VNX:

   #. Add the ``/opt/Navisphere/bin`` directory to the ``PATH`` environment
      variable:

      .. code-block:: console

       # export PATH=$PATH:/opt/Navisphere/bin

   #. Save your EMC credentials to simplify syntax in succeeding the
      :command:`naviseccli` commands:

      .. code-block:: console

       # naviseccli -addusersecurity -password <password> -scope 0 \
       -user <username>

   #. List LUNs created on EMC:

      .. code-block:: console

       # naviseccli -h <SP IP> lun -list

      .. image:: images/lunid.png
         :width: 90%

   In the given example, there is one successfully created LUN with:

   * ID: ``0``
   * Name: ``volume-e1626d9e-82e8-4279-808e-5fcd18016720`` (naming schema is
     ``volume-<Cinder volume id>``)
   * Current state: ``Ready``

   The IP address of the EMC VNX SP: 192.168.200.30

.. raw:: latex

   \pagebreak

5. Get the Glance image ID and the network ID:

   .. code-block:: console

    # glance image-list
    # nova net-list

   .. image:: images/glance.png
      :width: 90%

   The VM ID in the given example is ``48e70690-2590-45c7-b01d-6d69322991c3``.

#. Create a new VM using the Glance image ID and the network ID:

   .. code-block:: console

    # nova --flavor 2 --image <IMAGE_ID> -- nic net-id=<NIC_NET-ID> <VM_NAME>

.. raw:: latex

   \pagebreak

7. Check the ``STATUS`` of the new VM and on which node it has been created:

   .. code-block:: console

    # nova show <id>

   In the example output, the VM is running on ``node-3`` and is active:

   .. image:: images/novaShow.png
      :width: 90%

#. Attach the Cinder volume to the VM and verify its state:

   .. code-block:: console

    # nova volume-attach <VM id> <volume id>
    # cinder list

   The output looks as follows:

   .. image:: images/volumeAttach.png
      :width: 90%

.. raw:: latex

   \pagebreak

9. List the storage groups configured on EMC VNX:

   .. code-block:: console

    # naviseccli -h <SP IP> storagegroup -list

   The output looks as follows:

   .. image:: images/storagegroup.png
      :width: 90%

   In the example output, we have:

   * One storage group: ``node-3`` with one LUN attached.
   * Four iSCSI ``HBA/SP Pairs`` - one pair per the SP-Port.
   * The LUN that has the local ID ``0`` (``ALU Number``) and that is
     available as LUN ``133`` (``HLU Number``) for the ``node-3``.

.. raw:: latex

   \pagebreak

10. You can also check whether the iSCSI sessions are active:

   .. code-block:: console

    # naviseccli -h <SP IP> port -list -hba

   The output looks as follows:

   .. image:: images/hba.png
      :width: 90%

   Check the ``Logged In`` parameter of each port. In the example output,
   all four sessions are active as they have ``Logged In: YES``.

.. raw:: latex

   \pagebreak

11. When you log in to ``node-3``, you can verify that:

    * The iSCSI sessions are active:

      .. code-block:: console

       # iscsiadm -m session

    * A multipath device has been created by the multipath daemon:

      .. code-block:: console

       # multipath -ll

    * The VM is using the multipath device:

      .. code-block:: console

       # lsof -n -p `pgrep -f <VM id>` | grep /dev/<DM device name>

    .. image:: images/iscsiadmin.png
       :width: 90%

    In the example output, we have the following:

    * There are four active sessions (the same as on the EMC).
    * The multipath device ``dm-2`` has been created.
    * The multipath device has four paths and all are running (one per iSCSI
      session).
    * QEMU is using the ``/dev/dm-2`` multipath device.

.. raw:: latex

   \pagebreak

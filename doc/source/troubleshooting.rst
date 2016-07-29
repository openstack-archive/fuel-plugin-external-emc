Troubleshooting
===============

Most Cinder errors are caused by incorrect volume configuration that
result in the volume creation failures. To resolve these failures, use the
Cinder logs.

**To review the Cinder logs**

If you have issues with Cinder, find and review the following Cinder logs on
controller nodes:

#. The ``cinder-api`` log located at ``/var/log/cinder/api.log``.
#. The ``cinder-volume`` log located at ``/var/log/cinder/volume.log``.

Check the ``cinder-api`` log to determine whether you have the endpoint or
connectivity issues. If, for example, the *create volume* request fails,
review the ``cinder-api`` log to check whether the request made the call to
the Block Storage service. If the request is logged, and you see no errors or
tracebacks, check the ``cinder-volume`` log for errors or tracebacks.

**To verify the status of Cinder services**

Cinder services are running as Pacemaker resources. To verify the status of
services, run the following command on one of controller nodes:

.. code-block:: console

    # pcs resource show

All Cinder services should be in the ``started`` mode.

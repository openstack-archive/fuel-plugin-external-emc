=====================
Troubleshooting Guide
=====================

Most Cinder errors are caused by incorrect volume configurations that
result in volume creation failures. To resolve these failures, review these logs
on Controller nodes:

#. cinder-api log (/var/log/cinder/api.log)
#. cinder-volume log (/var/log/cinder/volume.log)

The cinder-api log is useful for determining if you have endpoint or connectivity
issues. If you send a request to create a volume and it fails, review the cinder-api
log to determine whether the request made it to the Block Storage service.
If the request is logged and you see no errors or trace-backs, check the cinder-volume
log for errors or trace-backs.

Cinder services are running as pacemaker resources. To verify status of services,
issue following command on one of Controllers::

    # pcs resource show

All Cinder services should be in "Started" mode.

#!/bin/ash
#
# Launch the podman service/process if not previously launched. If parameters are not provided
# launch as a process. If parameters provided fork the podman as a service.

echo "$0"
TEST="$(/usr/bin/pgrep nginix)"
if [ $? -eq 1 ] ; then
 echo "---------- [ HTTP SERVER(nginix) ] ----------"
 if [ -z "$ENTRYPOINT_PARAMS" ] ; then
  /usr/bin/sudo /usr/sbin/nginx -g "daemon off;"
 else
  /usr/bin/sudo /usr/sbin/nginx
 fi
fi

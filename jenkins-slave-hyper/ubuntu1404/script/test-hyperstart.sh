#!/usr/bin/env bash


echo ------------------------------------------------
cat /etc/os-release
echo ------------------------------------------------
cat /proc/cpuinfo | grep -E '(processor|model name|cpu cores)'
echo ------------------------------------------------
cat /proc/meminfo | grep ^Mem
echo ------------------------------------------------
echo "system information: `uname -a`"
echo ------------------------------------------------

echo "Start execute build script: `date '+%F %T'`"
export START_TS=`date '+%s'`
export START_TIME="`date "+%Y/%m/%d %H:%M:%S"`"
######################################
SLACK_CHANNEL_ID="${SLACK_CHANNEL_ID:-C7AB6M1NJ}"

TITLE="[${JOB_NAME}] test($sha1) - begin"
MESSAGE="*$TITLE* :$icon (http://ci.hypercontainer.io:8080/job/${JOB_NAME}/${BUILD_NUMBER}/console)"
ATTACHMENT="[{'text':'START_TIME: $START_TIME'}]"

# send begin message to slack
slack.sh "${SLACK_TOKEN}" "${SLACK_CHANNEL_ID}" "${MESSAGE}" "${ATTACHMENT}"

########################
export TRAVIS=false
export HYPER_EXEC_DRIVER=libvirt
export HYPER_STORAGE_DRIVER=overlay


########################
./autogen.sh
./configure
make

########################
modprobe tun
mount -t tmpfs cgroup_root /sys/fs/cgroup
mkdir /sys/fs/cgroup/devices
mount -t cgroup -o devices devices /sys/fs/cgroup/devices

#################
[ ! -x /etc/init.d/libvirt-bin ] || /etc/init.d/libvirt-bin restart
[ ! -x /etc/init.d/virtlogd ] || /etc/init.d/virtlogd restart
mkdir -p /sys/fs/cgroup/cpu,cpuacct
mount -t cgroup -o cpu,cpuacct none /sys/fs/cgroup/cpu,cpuacct

#################
#change aufs to overlay
sed -i '/make/ a sed -i "s/sudo //g" hack/test-cmd.sh' hack/test-cmd.sh
sed -i '/make/ a sed -i "s/aufs/overlay/g" hack/test-cmd.sh' hack/test-cmd.sh

sed -i '/.*autogen.sh/ i pwd' hack/test-cmd.sh
sed -i '/.*autogen.sh/ i hack/install-grpc.sh' hack/test-cmd.sh
sed -i '/.*autogen.sh/ i hack/verify-gofmt.sh' hack/test-cmd.sh
sed -i '/.*autogen.sh/ i hack/verify-generated-proto.sh' hack/test-cmd.sh


echo --------------------------------
cat hack/test-cmd.sh
echo --------------------------------


echo "-----run test-----"
export TITLE="[${JOB_NAME}] test($sha1) - end"
hack/test-cmd.sh
rlt=$?

#################
END_TS=`date '+%s'`
echo "Duration: $((END_TS - START_TS)) (seconds)"

###############################################

if [ $rlt -eq 0 ]
then
  icon=":smile:"
else
  icon=":scream:"
fi

MESSAGE="*$TITLE* :$icon (http://ci.hypercontainer.io:8080/job/${JOB_NAME}/${BUILD_NUMBER}/console)"
DURATION=$((END_TS - START_TS))" sec"
ATTACHMENT="[{'text':'START_TIME: $START_TIME'},{'text':'DURATION: $DURATION'},{'text':'TEST_RESULT: $rlt'}]"

# send end message to slack
slack.sh "${SLACK_TOKEN}" "${SLACK_CHANNEL_ID}" "${MESSAGE}" "${ATTACHMENT}"

rlt=$?
echo "-----run test-----"

exit $rlt

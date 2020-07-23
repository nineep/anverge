#!/bin/bash
#chkconfig: 2345 80 90
#description: Config cgroup for converge


MRIADB_PID=`ps -ef |grep mariadb|grep -v grep|awk '{print $2}'`

echo "MariaDB PID: $MRIADB_PID"

echo "Setting up MariaDB cpuset cgroup..."
/usr/bin/mkdir -p /sys/fs/cgroup/cpuset/mariadb
/usr/bin/echo "1" > /sys/fs/cgroup/cpuset/mariadb/cpuset.cpus
/usr/bin/echo "0" > /sys/fs/cgroup/cpuset/mariadb/cpuset.mems
/usr/bin/echo "$MRIADB_PID" > /sys/fs/cgroup/cpuset/mariadb/tasks

echo "Setting up MariaDB memory cgroup..."
/usr/bin/mkdir -p /sys/fs/cgroup/memory/mariadb
/usr/bin/echo "4G" > /sys/fs/cgroup/memory/mariadb/memory.limit_in_bytes
/usr/bin/echo "$MRIADB_PID" > /sys/fs/cgroup/memory/mariadb/tasks

CEPH_PIDS=`ps -ef |grep ceph|grep -v grep|awk '{print $2}'`

echo "Ceph PIDs: \n $CEPH_PIDS "


echo "Setting up Ceph cpuset cgroup..."
/usr/bin/mkdir -p /sys/fs/cgroup/cpuset/ceph
/usr/bin/echo '2-8' > /sys/fs/cgroup/cpuset/ceph/cpuset.cpus
/usr/bin/echo '0' > /sys/fs/cgroup/cpuset/ceph/cpuset.mems
#/usr/bin/echo "$CEPH_PIDS" > /sys/fs/cgroup/cpuset/ceph/tasks

for i in $CEPH_PIDS;
do
    /usr/bin/echo "$i" >> /sys/fs/cgroup/cpuset/ceph/tasks
done

echo "Setting up Ceph memory cgroup..."
/usr/bin/mkdir -p /sys/fs/cgroup/memory/ceph
/usr/bin/echo '28G' > /sys/fs/cgroup/memory/ceph/memory.limit_in_bytes
#/usr/bin/echo "$CEPH_PIDS" > /sys/fs/cgroup/memory/ceph/tasks

for j in $CEPH_PIDS;
do
    /usr/bin/echo "$j" >> /sys/fs/cgroup/memory/ceph/tasks
done


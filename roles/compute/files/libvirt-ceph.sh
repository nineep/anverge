#!/bin/bash
set -x

#UUID=`uuidgen`
UUID=afd20001-4d10-4067-aed3-7c5fbb962ec7

cat > secret.xml <<EOF
<secret ephemeral='no' private='yes'>
  <uuid>$UUID</uuid>
  <description>CEPH auth</description>
  <usage type='ceph'>
    <name>cephadmin</name>
  </usage>
</secret>
EOF

virsh secret-list | grep cephadmin
if [ $? -ne 0 ];then
    virsh secret-define --file secret.xml
fi

ceph auth get-key client.admin > client.admin.key

#virsh secret-get-value --secret $UUID | grep cephadmin
virsh secret-list | grep afd20001-4d10-4067-aed3-7c5fbb962ec7
if [ $? -eq 0 ];then
    virsh secret-set-value --secret $UUID --base64 $(cat ./client.admin.key)
fi

rm -f secret.xml client.admin.key


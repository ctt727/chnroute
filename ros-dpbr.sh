#!/bin/sh
rm -rf ./CN.rsc
mkdir -p ./pbr
cd ./pbr

# AS4809 BGP
# 备用地址 https://raw.githubusercontent.com/mayaxcn/china-ip-list/master/chnroute.txt
wget --no-check-certificate -c -O CN.txt https://www.iwik.org/ipcountry/CN.cidr

{
sed -i '1d' CN.txt
echo "/ip firewall address-list"

for net in $(cat CN.txt) ; do
  echo "add list=CN address=$net comment=AS4809"
done

} > ../CN.rsc

cd ..
rm -rf ./pbr

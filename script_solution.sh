#!/bin/bash

passFile="etc_passwd"
groupFile="etc_group"

arg1=$1
arg2=$2
no_arg="not argument found"
no_group="group $arg1 not found"

if [ $# -eq 0 ]
then
  echo $no_arg
  exit 1
fi


if [ "$arg2" = "uid" ]
then
  res="3"
  resName=$arg2
else
  res="1"
  resName="login"
fi

listUser=`grep -w "^$arg1" $groupFile | awk -F \: '{print $NF}' | sed 's/,/ /g'`

if [ "$listUser" = "" ]
then
    echo $no_group
    exit 1
fi

echo "user informations for $arg1 group:"
for i in $listUser
do
  echo "== $i =="
  userName=`grep -w "^$i" $passFile | awk -F \: '{print $5}' | awk -F \, '{print $1}'`
  loginName=`grep -w "^$i" $passFile | awk -F \: '{print $'"$res"'}' | awk -F \, '{print $1}'`
  echo "username = $userName"
  echo "$resName = $loginName"
  echo ==
done

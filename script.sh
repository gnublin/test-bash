#!/bin/bash

pass_file="etc_passwd"
group_file="etc_group"

arg1=$1
arg2=$2
no_arg="no argument found"
no_group="group $arg1 not found"

if [ -z $* ]; then
    echo $no_arg
    exit 1
fi

print_user_info(){
    #Give username as parameter
    while read line; do
        username=$(echo $line | awk -F ':' '{ print $1 }')
        if [ "$username" == "$1" ]; then
            echo "=== $username ==="
            echo "username: $username"
            if [ "$arg2" == "uid" ]; then
                user_uid=$(echo $line | awk -F ':' '{ print $3 }')
                echo "uid: $user_uid"
            else
                user_info=$(echo $line | awk -F ':' '{ print $5 }')
                stripped_info=$(echo $user_info | sed -r 's/,//g')
                echo "user info: $stripped_info"
            fi
        fi
    done < "$pass_file"
}

while read line; do
    groupname=$(echo $line | awk -F ':' '{ print $1 }')
    if [ "$groupname" == "$arg1" ]; then
        gid=$(echo $line | awk -F ':' '{ print $3 }')

        echo "== secondary group users =="
        sec_users=$(echo $line | awk -F ':' '{ print $4 }')
        sec_users=$(echo $sec_users | sed -r 's/,/ /g')
        for user in $(echo $sec_users); do
            print_user_info $user
        done
        break
    fi
done < "$group_file"

if [ -z $gid ]; then
    echo $no_group
    exit 1
fi

while read line; do
    user_gid=$(echo $line | awk -F ':' '{ print $4 }')
    if [ "$user_gid" == "$gid" ]; then
        username=$(echo $line | awk -F ':' '{ print $1 }')
        echo "== primary group users =="
        print_user_info $username
    fi
done < "$pass_file"
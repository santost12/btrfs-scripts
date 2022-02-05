#!/bin/bash

###
# This script makes a lot of assumptions!
# 1) Assumes your /etc/fstab is setup!
# 2) Assumes you keep your data in /data/ subvolume.
# 3) Assumes you keep your snapshots in /snapshots/ subvolume.
# 4) You run it once a day at most.
###

# mount points for each of the drives
mountPoints=(/mnt/hdd/ /mnt/oldhdd/)

# I'm using year-month-day format. Example: 2022-1-20
currentDate=$(date +%y-%m-%d)

function unmountAll()
{
	for mnt in "${mountPoints[@]}";
		do sudo umount "$mnt";
	done
}


function mountRootOfDrives()
{
	for mnt in "${mountPoints[@]}";
		do sudo mount "$mnt" -o noatime,subvolid=0;
	done
}


function snapshot()
{
	for mnt in "${mountPoints[@]}";
		do sudo btrfs subvolume snapshot "$mnt"data/ "$mnt"snapshots/"$currentDate";
	done
}


function regularMount()
{
	for mnt in "${mountPoints[@]}";
		do sudo mount "$mnt";
	done
}


unmountAll

mountRootOfDrives

snapshot

unmountAll

regularMount

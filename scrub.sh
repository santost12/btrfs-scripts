#!/bin/bash

mountPoints=(/mnt/hdd/ /mnt/oldhdd/)

for mnt in "${mountPoints[@]}";
  do btrfs scrub start "$mnt";
done

echo $(date) > /var/log/last-btrfs-scrub.txt

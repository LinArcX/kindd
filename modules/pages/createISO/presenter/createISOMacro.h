#pragma once
#define HARD_DISK "dd if=$IMAGE of=$DEVICE bs=$BSIZE oflag=sync status=progress"
#define LIST_OF_DEVICES "for devlink in /dev/disk/by-id/usb*; do readlink -f ${devlink}; done"
//#define LIST_OF_DEVICES "lsblk"

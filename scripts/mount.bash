#!/usr/bin/env bash

DUNST="dunstify -u normal -i"
ICON_MOUNTED_PATH="$XDG_CONFIG_HOME/eww/assets/images/hdd-mount.svg"
ICON_UNMOUNTED_PATH="$XDG_CONFIG_HOME/eww/assets/images/hdd-unmount.svg"

udisks2_is_mounted() {
    udisksctl info -b /dev/"$1" | grep MountPoints: | awk '{print $2}'
}

mount_nvme() {
    STATE=$(udisks2_is_mounted nvme0n1p1)
    if [ "$STATE" == "" ]; then
        eval "$DUNST $ICON_MOUNTED_PATH 'Mounting...' 'Mounting nvme0n1p1'"
        kitty udisksctl mount -b /dev/nvme0n1p1
    else
        eval "$DUNST $ICON_UNMOUNTED_PATH 'Unmounting...' 'nvme0n1p1 is being un-mounted'"
        udisksctl unmount -b /dev/nvme0n1p1
    fi
}

mount_sdb() {
    STATE=$(udisks2_is_mounted sdb1)
    if [ "$STATE" == "" ]; then
        eval "$DUNST $ICON_MOUNTED_PATH 'Mounting...' 'sdb1 is being mounted'"
        udisksctl mount -b /dev/sdb1
    else
        eval "$DUNST $ICON_UNMOUNTED_PATH 'Unmounting...' 'sdb1 is being unmounted'"
        udisksctl unmount -b /dev/sdb1
    fi
}

mount_sdc() {
    STATE=$(udisks2_is_mounted sdc1)
    if [ "$STATE" == "" ]; then
        eval "$DUNST $ICON_MOUNTED_PATH 'Mounting...' 'sdc1 is being mounted'"
        udisksctl mount -b /dev/sdc1
    else
        eval "$DUNST $ICON_UNMOUNTED_PATH 'Unmounting...' 'sdc1 is being unmounted'"
        udisksctl unmount -b /dev/sdc1
    fi
}

mount_sdd() {
    STATE=$(udisks2_is_mounted sdd1)
    if [ "$STATE" == "" ]; then
        eval "$DUNST $ICON_MOUNTED_PATH 'Mounting...' 'sdd1 is being mounted'"
        udisksctl mount -b /dev/sdd1
    else
        eval "$DUNST $ICON_UNMOUNTED_PATH 'Unmounting...' 'sdd1 is being unmounted'"
        udisksctl unmount -b /dev/sdd1
    fi
}

mount_cell() {
    if [ -z "$(ls -A "$HOME"/Phone)" ]; then
        eval "$DUNST $ICON_MOUNTED_PATH 'Mounting...' 'cell is being mounted'"
        kitty go-mtpfs "$HOME"/Phone
    else
        eval "$DUNST $ICON_UNMOUNTED_PATH 'Unmounting...' 'cell is being unmounted'"
        fusermount -u "$HOME"/Phone
    fi
}

icon_nvme() {
    STATE=$(udisks2_is_mounted nvme0n1p1)
    if [ "$STATE" != "" ]; then
        echo ""
    else
        echo ""
    fi
}

icon_cell() {
    if [ -z "$(ls -A ~/Phone)" ]; then
        echo ""
    else
        echo ""
    fi
}

icon_sdb() {
    STATE=$(udisks2_is_mounted sdb1)
    if [ "$STATE" != "" ]; then
        echo "ﯾ"
    else
        echo "ﯿ"
    fi
}

icon_sdc() {
    STATE=$(udisks2_is_mounted sdc1)
    if [ "$STATE" != "" ]; then
        echo "ﯾ"
    else
        echo "ﯿ"
    fi
}

icon_sdd() {
    STATE=$(udisks2_is_mounted sdd1)
    if [ "$STATE" != "" ]; then
        echo "ﯾ"
    else
        echo "ﯿ"
    fi
}

case "$1" in
    --nvme) mount_nvme;;
    --cell) mount_cell;;

    --sdb) mount_sdb;;
    --sdc) mount_sdc;;
    --sdd) mount_sdd;;

    --icon-cell) icon_cell;;
    --icon-nvme) icon_nvme;;

    --icon-sdb) icon_sdb;;
    --icon-sdc) icon_sdc;;
    --icon-sdd) icon_sdd;;

    *) echo Invalid Option!;;
esac

# vim:ft=bash:nowrap

#!/system/bin/sh

LOGTAG="ROFIKKERNELDEVGSI"

logi() {
    echo "$LOGTAG: $1" > /dev/kmsg
}

ROFIKKERNEL_DIR="/system/system/rofikkernel"

logi "rw-system-add.sh started"

# Verify source paths
ls -l "$ROFIKKERNEL_DIR" > /dev/kmsg 2>&1
ls -l "$ROFIKKERNEL_DIR/vo" > /dev/kmsg 2>&1

# Vendor overlay
if [ -d "$ROFIKKERNEL_DIR/vo" ]; then
    if mount -o bind "$ROFIKKERNEL_DIR/vo" /vendor/overlay; then
        logi "overlay bind mounted"
    else
        logi "overlay bind FAILED"
    fi
else
    logi "overlay source missing"
fi

# passwd
if [ -f "$ROFIKKERNEL_DIR/passwd" ]; then
    if mount -o bind "$ROFIKKERNEL_DIR/passwd" /vendor/etc/passwd; then
        logi "passwd bind mounted"
    else
        logi "passwd bind FAILED"
    fi
else
    logi "passwd source missing"
fi

# group
if [ -f "$ROFIKKERNEL_DIR/group" ]; then
    if mount -o bind "$ROFIKKERNEL_DIR/group" /vendor/etc/group; then
        logi "group bind mounted"
    else
        logi "group bind FAILED"
    fi
else
    logi "group source missing"
fi

# Verify mounts
mount | grep vendor > /dev/kmsg 2>&1

logi "rw-system-add.sh finished"

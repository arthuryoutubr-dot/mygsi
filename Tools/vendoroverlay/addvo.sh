#/bin/bash

SCRIPT_DIR=$(dirname "$0")
BASE_DIR="$1"

SOURCE_VENDOR="UnpackedROMs/vendor"
ROFIKKERNEL_DIR="$BASE_DIR/system/system/rofikkernel"

mkdir -p "$ROFIKKERNEL_DIR"

if [ -d "$SOURCE_VENDOR/overlay" ]; then
    mkdir -p "$ROFIKKERNEL_DIR/vo"
    cp -a "$SOURCE_VENDOR/overlay/." "$ROFIKKERNEL_DIR/vo/"
fi

if [ -f "$SOURCE_VENDOR/etc/passwd" ]; then
    cp "$SOURCE_VENDOR/etc/passwd" \
       "$ROFIKKERNEL_DIR/passwd"
fi

if [ -f "$SOURCE_VENDOR/etc/group" ]; then
    cp "$SOURCE_VENDOR/etc/group" \
       "$ROFIKKERNEL_DIR/group"
fi

cat "$SCRIPT_DIR/rw-system-add.sh" \
>> "$BASE_DIR/system/bin/rw-system.sh"

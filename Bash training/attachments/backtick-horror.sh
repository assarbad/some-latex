#!/usr/bin/env bash
set -x # this option lets us see commands executing in subshells
echo "`stat -c \"%z\" \"/boot/vmlinuz-\` uname -r\`\"`"
KERNELFILE="/boot/vmlinuz-$(uname -r)"
TIMESTAMP=$(stat -c "%z" "$KERNELFILE")
echo "$TIMESTAMP"


#!/usr/bin/env bash
KERNELFILE="/boot/vmlinuz-$(uname -r)"
TIMESTAMP=$(stat -c "%z" "$KERNELFILE")
echo "$TIMESTAMP"
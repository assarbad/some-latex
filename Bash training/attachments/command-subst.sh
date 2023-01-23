#!/usr/bin/env bash
echo "$(stat -c "%z" "/boot/vmlinuz-$(uname -r)")"
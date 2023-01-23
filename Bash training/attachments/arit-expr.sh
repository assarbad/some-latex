#!/usr/bin/env bash
if ((EUID > 0)); then
  echo "You are not superuser"
fi
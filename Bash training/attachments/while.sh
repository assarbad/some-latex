#!/usr/bin/env bash
find -type f | while read fname; do
  echo "$fname"
done
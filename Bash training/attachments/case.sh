#!/usr/bin/env bash
case $VAR in
  prefix*|pfx*)
    echo "Found a prefix"
    ;;
  *suffix|*ext)
    echo "Found a suffix"
    ;;
  *)
    echo "Unexpected $VAR"
    ;;
esac
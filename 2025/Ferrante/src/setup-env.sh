#!/bin/bash
export PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig"
for pkg in rrdtool net-snmp ndpi; do
  prefix=$(brew --prefix $pkg 2>/dev/null)
  if [ -n "$prefix" ]; then
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$prefix/lib/pkgconfig"
  fi
done


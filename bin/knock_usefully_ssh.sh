#!/bin/sh
knock -vd15 104.238.147.123 7700:tcp 7100:tcp 7000:tcp 7200:tcp
sleep 1
exec ssh bougyman@104.238.147.123 -p 7102 "$@"

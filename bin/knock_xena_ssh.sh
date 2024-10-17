#!/bin/sh
knock -vd15 104.14.113.221 17171:tcp 19191:tcp 17171:tcp
sleep 1
exec ssh xena "$@"

#!/bin/bash --noprofile

if [ `curl -s -I 'http://william-boyer.com' | egrep '301 Moved Permanently|Location: http://www.bill-boyer.com' | wc -l` = 2 ]; then
  exit 0
else
  exit 1
fi

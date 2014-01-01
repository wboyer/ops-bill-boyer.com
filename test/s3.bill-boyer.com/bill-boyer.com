#!/bin/bash --noprofile

curl -s 'http://s3.bill-boyer.com' | grep 'Index page.' >& /dev/null

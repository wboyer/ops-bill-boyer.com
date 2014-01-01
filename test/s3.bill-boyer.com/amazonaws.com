#!/bin/bash --noprofile

curl -s 'http://s3.bill-boyer.com.s3-website-us-east-1.amazonaws.com' | grep 'Index page.' >& /dev/null

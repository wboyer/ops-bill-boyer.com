#!/bin/bash --noprofile

curl -s 'http://ec2-54-201-103-22.us-west-2.compute.amazonaws.com/' | grep 'This panel will appear on every page' >& /dev/null

#!/bin/sh

echo "Type in the MySQL password below when it asks"
mysql -u pd_tester -p --database pd_test -h bmw.stanford.edu

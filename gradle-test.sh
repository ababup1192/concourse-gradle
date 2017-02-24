#!/bin/bash
cd gradle-project

gradle test
status=$(echo $?)

cp -r build ../out
cp -r src/test/java ../out
echo $status > ../result/status

exit $status

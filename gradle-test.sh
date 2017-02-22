#!/bin/bash
cd gradle-project

gradle test
status=$(echo $?)

cp -r build ../out
echo $status > ../result/status

exit $status

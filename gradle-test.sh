#!/bin/bash
cd gradle-project

gradle test
status=$(echo $?)

cp -r build ../out

exit $status

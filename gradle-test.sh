#!/bin/bash
cd gradle-project

gradle test
status=$(echo $?)

cp -r build ../out

echo ===start===
ls ../out
echo ===end===
echo $status

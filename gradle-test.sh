#!/bin/bash
cd gradle-project
STATUS=gradle test
cp -r build ../out
echo ===start===
ls ../out
echo ===end===
return STATUS

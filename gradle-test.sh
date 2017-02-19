#!/bin/bash
cd gradle-project
STATUS=gradle test
cp -r build/* ../out
return STATUS

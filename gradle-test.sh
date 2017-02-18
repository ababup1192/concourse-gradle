#!/bin/bash
cd gradle-project
gradle test
cp -r build ../out

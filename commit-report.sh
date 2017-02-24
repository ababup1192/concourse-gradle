#!/bin/bash

git clone report updated-report

cd updated-report/

ls ../out/
cp -a ../out/java/* ./
cp -a ../out/build/reports ../out/build/test-results ./

git config --global user.email "nobody@concourse.ci"
git config --global user.name "Concourse"

git remote -v

git add -A
git commit -m "Update report" -a

#!/bin/bash

git clone report updated-report

cd updated-report/

cp -a ../out/* ./

git config --global user.email "ababup1192@gmail.com"
git config --global user.name "ababup1192"

git remote -v

git add -A
git commit -m "Update report" -a
git push origin master

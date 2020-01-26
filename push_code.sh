#!/bin/bash 

cd /home/ubuntu/svn_project/my_gitbook/
# git checkout master
# gitbook install; gitbook build
git add .
git commit -am "保存进度"
git push gitee_origin master
git push origin master

cp _book /home/ubuntu/Documents/ -r
git checkout gh-pages
if [[ $? -eq 0 ]]; then
	rm -rf ./*
fi
mv /home/ubuntu/Documents//_book/* .
rm -rf /home/ubunu/Documents/_book
git add .
git commit -am "保存进度"
git push origin gh-pages
git push gitee_origin gh-pages
git checkout master

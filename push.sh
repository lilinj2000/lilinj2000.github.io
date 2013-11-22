#! /bin/sh

echo "add ..."
git add .

echo "commit ..."
git commit -m "updated."

echo "pull ..."
git pull

echo "push ..."
git push origin source

echo "push done."
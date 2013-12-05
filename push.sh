#! /bin/sh

echo "add ..."
git add .

echo "commit ..."
if [ "x$1" != "x" ]
then
  git commit -m "$1"
else
  git commit -m "updated."
fi

echo "pull ..."
git pull

echo "push ..."
git push origin source

echo "push done."

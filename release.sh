#!/bin/sh
branch=$(git rev-parse --abbrev-ref HEAD)

exec < /dev/tty

if [ $branch == "master" ]; then
  echo "DETECTED PUSH TO MASTER
Please set version number, current version is: x.x.x.x"
  read -p "> " version_number
  echo "Version number set to $version_number"
  sed "s/\"\([^\"]*\)\"/\"$version_number\"/" version.go > version.go.new
  mv version.go.new version.go
  git add version.go
  git commit -m "Update version to $version_number."
  # git push --no-verify
fi

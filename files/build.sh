#!/bin/sh

set -e

bootstrap() {
  mkdir -p "$REPODEST" /home/builder/.abuild
  [ "$RSA_PRIVATE_KEY" ] && {
    echo -e "$RSA_PRIVATE_KEY" > "/home/builder/.abuild/$RSA_PRIVATE_KEY_NAME"
    export PACKAGER_PRIVKEY="/home/builder/.abuild/$RSA_PRIVATE_KEY_NAME"
  }
  [ "$RSA_PUBLIC_KEY" ] && {
    echo -e "$RSA_PUBLIC_KEY" | sudo tee -a "/etc/apk/keys/$RSA_PRIVATE_KEY_NAME.pub" > /dev/null
  }
  sudo chown -R builder:abuild /home/builder
  sudo chown -R builder:abuild $REPODEST
}

buildall() {
  echo "Building all packages in /main"
  for d in main/*
  do
    ( cd $d && abuild-apk update && abuild -r )
  done
}

build() {
    echo "Building /main/$1"
    ( cd main/$1 && abuild-apk update && abuild -r )
}

echo "$@"

bootstrap "$@"
if [[ $# -eq 0 ]]; then
    buildall "$@"
    exit 0
fi

build "$1"
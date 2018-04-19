#!/bin/sh

cd ${TMPDIR:-/tmp}

if [ $(uname) = 'Darwin' ]; then
  TEXDIR=~/Library/TinyTeX
  alias download='curl -sL'
else
  TEXDIR=~/.TinyTeX
  alias download='wget -qO-'
fi

download https://github.com/skiyer/tinytex/raw/master/tools/install-base.sh | sh -s - "$@"

rm -rf $TEXDIR
mkdir -p $TEXDIR
mv texlive/* $TEXDIR
rm -r texlive

$TEXDIR/bin/*/tlmgr install $(download https://github.com/skiyer/tinytex/raw/master/tools/pkgs-skiyer.txt | tr '\n' ' ')

if [ "$1" = '--admin' ]; then
  if [ "$2" != '--no-path' ]; then
    sudo $TEXDIR/bin/*/tlmgr path add
  fi
else
  $TEXDIR/bin/*/tlmgr path add
fi

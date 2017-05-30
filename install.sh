#!/usr/bin/env sh

for dotfile in .*
do
  ln -sf $PWD/$dotfile $HOME/$dotfile
done

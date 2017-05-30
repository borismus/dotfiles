#!/usr/bin/env zsh

for dotfile in .*
do
  ln -sf $PWD/$dotfile $HOME
done

#!/usr/bin/env sh

for dotfile in .*
do
  # Do not copy the .git directory.
  if [[ "$dotfile" == ".git" ]]; then
    continue
  fi
  ln -sf $PWD/$dotfile $HOME/$dotfile
done

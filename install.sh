#!/usr/bin/env sh

for dotfile in .*
do
  # Do not copy the .git directory.
  if [[ "$dotfile" == ".git" ]]; then
    continue
  fi
  # Do not copy the .gitignore file.
  if [[ "$dotfile" == ".gitignore" ]]; then
    continue
  fi
  ln -sf $PWD/$dotfile $HOME/$dotfile
done

ln -s $PWD/bin $HOME/bin

#!/bin/sh

[[ $(id -u) -eq 0 ]] || { echo please run as root; exit }
pacman -Syu git --no-confirm
git clone 'https://github.com/pxeger/dotfiles.git' /dev/shm/dotfiles
cd /dev/shm/dotfiles
pacman $(< packages tr '\n' ' ')
useradd pxeger -s zsh
cp home_template /home/pxeger/home
rm /home/pxeger/**/.keep
chown -R pxeger:pxeger /home/pxeger
chmod -R o-rwx,g-w,g+r /home/pxeger



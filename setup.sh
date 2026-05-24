#!/bin/bash
apt clean
apt update -y
apt upgrade -y

apts = "git stow tree python3 python3-pip python3-venv latexmk sl texlive-base texlive-font-utils texlive-science texlive-extra-utils texlive-latex-extra"
apt install -y $apts

snap install vivaldi
snap install nvim --classic

curl -o Downloads/1password.deb -L "https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb"

# radio
# add-apt-repository ppa:gnuradio/gnuradio-releases
# snap install gqrx
# snap install sdrangel
# apt install gnuradio

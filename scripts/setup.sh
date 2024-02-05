#! /bin/bash

# Update system ///////////////////////////////////////////////
sudo apt update -y && sudo apt upgrade -y

# Setup dual boot legacy/GRUB /////////////////////////////////
sudo apt install os-prober -y
sudo os-prober
cp /etc/default/grub $HOME
printf "GRUB_DISABLE_OS_PROBER=false\n" >> $HOME/grub
sudo mv $HOME/grub /etc/default/grub
sudo update-grub

# Git Credential Manager //////////////////////////////////////
wget "https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.696/gcmcore-linux_amd64.2.0.696.deb" -O /tmp/gcmcore.deb
sudo dpkg -i /tmp/gcmcore.deb
git-credential-manager-core configure

# Pull Dotfiles Repo //////////////////////////////////////////
mkdir -p $HOME/Projects/dotfiles/
cd $HOME/Projects/dotfiles/
git clone --bare https://github.com/ge3224/.dotfiles.git bare.git
cd $HOME/Projects/dotfiles/bare.git
git worktree add ../pop_os pop_os

# Kitty ///////////////////////////////////////////////////////
sudo apt install kitty -y
sudo update-alternatives --config x-terminal-emulator
ln -s $HOME/Projects/dotfiles/pop_os/kitty/.config/kitty $HOME/.config/kitty

# Bash ////////////////////////////////////////////////////////
rm $HOME/.bashrc
ln -s $HOME/Projects/dotfiles/pop_os/bash/.bashrc $HOME/.bashrc

# Neovim //////////////////////////////////////////////////////
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
mkdir $HOME/Projects/neovim
cd $HOME/Projects/neovim
git clone --bare https://github.com/neovim/neovim.git ../bare.git
cd $HOME/Projects/neovim/bare.git
git worktree add ../master master
cd $HOME/Projects/neovim/master && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
mkdir $HOME/Projects/nvim_cfg/
cd $HOME/Projects/nvim_cfg
git clone --bare https://github.com/ge3224/nvim_cfg.git bare.git
cd $HOME/Projects/nvim_cfg/bare.git
git worktree add ../main main
ln -s $HOME/Projects/nvim_cfg/main/ $HOME/.config/nvim/
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# RedShift ////////////////////////////////////////////////////
sudo apt install redshift redshift-gtk
ln -s $HOME/Projects/dotfiles/pop_os/redshift/.config/redshift $HOME/.config/redshift

# Brave ///////////////////////////////////////////////////////
sudo apt install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y
sudo apt remove firefox -y

# npm ///////////////////////////////////////////////////////
sudo apt install nodejs -y
sudo apt install npm -y

# Rust //////////////////////////////////////////////////////
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Go ////////////////////////////////////////////////////////
sudo apt install golang -y

# Telegram ////////////////////////////////////////////////////
sudo apt install telegram-desktop -y

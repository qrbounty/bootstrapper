#!/bin/bash
#
# This is a setup script for my systems.
#
# TODO: OSX install tasks
# TODO: Custom git repos
# TODO: Add dry run functionality
# TODO: Move open-vm-tools package to an installer that will actually detect if it's a VM...
# TODO: Better "custom app" management. Right now just dumping them into functions.
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root using sudo. User-specific data will be assigned to the user you are sudoing from."
  exit
fi

dotfile_repo="https://www.github.com/qrbounty/dotfiles.git"
user_home=$(getent passwd $SUDO_USER | cut -d: -f6)


### Helpers / Formatters ###
# Print a horizontal rule
# Source: https://brettterpstra.com/2015/02/20/shell-trick-printf-rules/
rule() { printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}; }
# Print a rule with a message in it
rulem() {
  if [ $# -eq 0 ]; then
    echo "Usage: rulem MESSAGE [RULE_CHARACTER]"
  return 1
  fi
  # Fill line with ruler character ($2, default "-"), reset cursor, move 2 cols right, print message
  printf -v _hr "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1"
}

# Source: Modified from https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script 
os() { [[ $OSTYPE == *$1* ]]; }
distro() { [[ $(cat /etc/*-release | grep -w NAME | cut -d= -f2 | tr -d '"') == *$1* ]]; }
linux() { 
  case "$OSTYPE" in
    *linux*|*hurd*|*msys*|*cygwin*|*sua*|*interix*) sys="gnu";;
    *bsd*|*darwin*) sys="bsd";;
  esac
  [[ "${sys}" == "$1" ]];
}

# Source: https://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script
exists() { command -v "$1" >/dev/null 2>&1; }

# Source: https://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs
error() { printf "$@\n" >&2; exit 1; }
success() { printf "$@\n\n"; }
log() { printf "$@\n"; }
try() { "$1" && success "$2" || error "Failure at $1"; }

apt_install() {
  printf "Installing package $1 ... " 
  if ! dpkg -s $1 >/dev/null 2>&1; then
    DEBIAN_FRONTEND=noninteractive apt-get install -qq $1 < /dev/null > /dev/null && echo "Installed!"
  else
    echo "Skipped."
  fi
}

### Installer Functions ###

debian_install() { 
  apt-get update < /dev/null > /dev/null && echo "Apt updated"
  declare -a debian_packages=("curl" "git" "python3" "python3-pip" "fonts-powerline" "vim" "suckless-tools" "i3" "i3blocks" "zsh" "xorg" "tmux" "lightdm" "rofi" "kitty" "open-vm-tools-desktop")
  for package in "${debian_packages[@]}"; do
    apt_install $package
  done
  dpkg-reconfigure lightdm
  echo 'exec i3' > $user_home/.xsession
  
  # Zsh config
  rulem "Installing Oh My Zsh"
  /bin/su -c "wget -q https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | sh > /dev/null" - $SUDO_USER
  #git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $user_home/.oh-my-zsh/custom/themes/powerlevel10k > /dev/null
  cp $user_home/.oh-my-zsh/templates/zshrc.zsh-template $user_home/.zshrc
  #sed -i '/ZSH_THEME/d' $user_home/.zshrc
  #echo "ZSH_THEME=powerlevel10k/powerlevel10k" >> $user_home/.zshrc
  #echo "POWERLEVEL9K_MODE=awesome-patched" >> $user_home/.zshrc
  chsh -s /bin/zsh $SUDO_USER
  
  # VS Code install
  rulem "Installing VS Code"
  curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  apt_install apt-transport-https
  apt-get update < /dev/null > /dev/null && echo "Apt updated"
  apt_install code
  rm packages.microsoft.gpg
}

pip3_packages() { 
  declare -a pip3_packages=("yara")
  for package in "${pip3_packages[@]}"; do
    echo "Installing $package ... "
    pip3 -q install $package; < /dev/null > /dev/null && echo "Installed!"
  done 
}

debian_re_packages() {
  apt-get update < /dev/null > /dev/null && echo "Apt updated"
  declare -a debian_packages=("radare2" "gdb" "binwalk")
  for package in "${debian_packages[@]}"; do
    apt_install $package
  done
}

### Dotfile Stuff ###
config(){ /usr/bin/git --git-dir=$user_home/.cfg/ --work-tree=$user_home $@; }
dotfile_copy(){
  [ ! -d "$user_home/.cfg" ] && /bin/su -c "mkdir $user_home/.cfg" - $SUDO_USER
  /bin/su -c "git clone --bare $dotfile_repo $user_home/.cfg" - $SUDO_USER
  [ ! -d "$user_home/.config-backup" ] && /bin/su -c "mkdir -p .config-backup" - $SUDO_USER
  /bin/su -c "/usr/bin/git --git-dir=$user_home/.cfg/ --work-tree=$user_home checkout -f" - $SUDO_USER
  if [ $? = 0 ]; then
    echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    /bin/su -c "/usr/bin/git --git-dir=$user_home/.cfg/ --work-tree=$user_home checkout" - $SUDO_USER 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv $user_home/{} $user_home/.config-backup/{}
  fi;
  /bin/su -c "/usr/bin/git --git-dir=$user_home/.cfg/ --work-tree=$user_home checkout" - $SUDO_USER
  /bin/su -c "/usr/bin/git --git-dir=$user_home/.cfg/ --work-tree=$user_home config status.showUntrackedFiles no" - $SUDO_USER
}

###  Main  ###
rule "-"
printf "QRBounty's System Bootstrap Script Version 1.1\n"
rule "-"
printf "\n"

rulem "!!!WARNING!!!" "#"
printf "\nWARNING: THIS WILL OVERWRITE LOCAL FILES!"
printf "\nThis is for FRESHLY INSTALLED systems only!\n\n"
rulem "!!!WARNING!!!" "#"

echo "Really continue?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done


if os darwin; then
  if ! exists brew; then
    log "Brew installed... This is where I would install other programs, IF I HAD ANY!"
  else
    log "Installing Brew..."
  fi 
elif linux gnu; then
  if distro "Debian"; then
    rulem "Debian Customization" "~"
    rulem "Installing Debian software" 
    try debian_install "Installed debian packages"
    rulem "Installing pip3 packages" 
    try pip3_packages "Installed pip3 packages"
    rulem "Installing reverse engineering tools" 
    try debian_re_packages "Installed reverse engineering tools"
  fi
  if distro "Kali"; then
    rulem "Kali Customization" "~"
  fi
  if exists git; then
    rulem "Dotfile Installation" "~"
    try "Grabbing dotfiles. Conflicts will be saved to .config-backup" dotfile_copy
  else
    err "git not detected, cannot gather dotfiles."
  fi
fi

rule "~"
echo "Installation has finished. Restart system?"
rule "~"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) reboot;;
        No ) exit;;
    esac
done

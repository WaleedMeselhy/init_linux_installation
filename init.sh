#! /bin/bash
set -e

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
USER="waled"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade -y

# utilities
sudo dnf install -y arandr \
    ffmpeg \
    keepass \
    pcmanfm \
    okular \
    simplenote \
    teamviewer \
    snapd \
    peek \
    vlc \
    torbrowser-launcher

#fonts
sudo dnf install -y fira-code-fonts fontawesome-fonts powerline-fonts

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo dnf install -y docker-compose

sudo dnf install -y git-cola meld code

the_silver_searcher
zsh  htop nnn

chsh waleed -s $(which zsh)

sudo -i -u waleed zsh <<EOF
rm -rf  ~/.oh-my-zsh
zsh  $(wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O -) --unattended
EOF
sudo -i -u waleed zsh <<EOF
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
then
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
EOF

sudo -i -u waleed zsh <<EOF
if [ ! -d ~/.fzf ]
then
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
fi
EOF

sudo cp $ABSDIR/shopt /usr/bin/shopt
sudo chmod +x /usr/bin/shopt

sudo -i -u waleed bash <<EOF
cp $ABSDIR/.zshrc ~/.zshrc
EOF

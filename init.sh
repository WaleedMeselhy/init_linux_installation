set -e
sudo apt-get install -y terminator \
                    zsh \
                    fonts-powerline


ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)


chsh waleed -s $(which zsh)

sudo -i -u waleed zsh << EOF
rm -rf  ~/.oh-my-zsh
zsh  $(wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O -) --unattended
EOF
sudo -i -u waleed zsh << EOF
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
then
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
EOF

sudo -i -u waleed zsh << EOF
if [ ! -d ~/.fzf ]
then
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
fi
EOF

sudo cp $ABSDIR/shopt /usr/bin/shopt
sudo chmod +x /usr/bin/shopt

sudo -i -u waleed bash << EOF
cp $ABSDIR/.zshrc ~/.zshrc
EOF


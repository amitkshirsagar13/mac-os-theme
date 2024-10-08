#!/bin/sh
# Install Pre-required softwares
sudo apt install git curl wget sassc gnome-tweaks gnome-shell-extension-manager neofetch zsh jq git-lfs -y

mkdir -p ~/bin
cp -f blob/bin/* ~/bin

# Install Fonts
echo 'Installing MesloLGS NF Fonts'
mkdir -p ~/.local/share/fonts
cp -f blob/fonts/*.ttf ~/.local/share/fonts/
sudo fc-cache -fv >> /dev/null 2>&1
fc-list | grep Meslo

# Install Powerlevel10k
echo 'Installing powerlevel10k'
chsh -s $(which zsh)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
cp -f blob/profile/* ~/
touch .zdocker .zk8s .wifi
echo "
* * * * * ~/bin/zdocker >> /dev/null 2>&1
* * * * * ~/bin/zk8s >> /dev/null 2>&1
* * * * * ~/bin/wifi >> /dev/null 2>&1
";

# Install Icons
echo 'Installing Icons to ~/.icons'
mkdir -p ~/.icons/
cp -f blob/icons/* ~/.icons/


# Installing Mac OS Theme
echo 'Installing Mac OS Background'
cd ~/git
git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
cd ~/git/WhiteSur-wallpapers
chmod 755 *.sh
./install-gnome-backgrounds.sh
./install-wallpapers.sh

echo 'Installing Mac OS Theme'
mkdir ~/git
cd ~/git
rm -rf WhiteSur-gtk-theme
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd ~/git/WhiteSur-gtk-theme
chmod 755 *.sh
./install.sh -a normal -m -t all -l -c Dark -N stable
sudo ./tweaks.sh -g
./tweaks.sh -F -f default
sudo flatpak override --filesystem=xdg-config/gtk-4.0
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'


# Install Gnome Extensions

array=( blur-my-shell@aunetx dev-container-manager@devopsnextgenx monitor@astraext.github.io search-light@icedman.github.com CoverflowAltTab@palatis.blogspot.com gnome-ui-tune@itstime.tech quick-settings-tweaks@qwreey user-theme@gnome-shell-extensions.gcampax.github.com dash-to-dock@micxgx.gmail.com just-perfection-desktop@just-perfection Rounded_Corners@lennart-k logomenu@aryan_k )

for i in "${array[@]}"
do
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${i}.zip "https://extensions.gnome.org/download-extension/${i}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${i}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
    fi
    gnome-extensions enable ${i}
    rm ${EXTENSION_ID}.zip
done

# Update VS Code and other Settings
echo "
Add below to settings.json in vs code
    "terminal.integrated.fontFamily": "MesloLGS NF, Regular"
"
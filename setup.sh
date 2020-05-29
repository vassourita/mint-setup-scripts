# ----- configurações iniciais -----
sudo rm /var/lib/dpkg/lock-frontend;
sudo rm /var/cache/apt/archives/lock;
sudo apt update &&
sudo apt install python3 python-pip winehq-stable linux-headers-$(uname -r) libreadline-dev zlib1g-dev build-essential libssl-dev flatpak gnome-software-plugin-flatpak curl dirmngr apt-transport-https git lsb-release ca-certificates snapd unzip -y &&
sudo apt install -f &&

# ----- adicionar repositórios e chaves -----
# > chrome 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &&
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&
# > spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - &&
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list &&
# > code
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' &&
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg &&
# > insomnia
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list &&
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add - &&
# > simplescreenrecorder
sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder -y &&

# ----- instalar pacotes apt -----
sudo apt update &&
sudo apt install -f &&
sudo apt install docky google-chrome-stable spotify-client insomnia gimp inkscape flameshot simplescreenrecorder -y &&
sudo apt update &&
sudo apt install mysql-server mysql-client mysql-workbench code -y &&

# ----- adicionar .debs e instalar -----
sudo apt install -f &&
wget "https://discordapp.com/api/download?platform=linux&format=deb" -O discord.deb &&
sudo dpkg -i discord.deb &&
sudo apt install -f &&

# ----- configurar asdf -----
sudo apt update &&
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8 &&
echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc &&
echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc &&
asdf plugin-add postgres &&
asdf plugin-add flutter &&
asdf plugin-add dart https://github.com/patoconnor43/asdf-dart.git &&
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git &&
asdf plugin-add kotlin https://github.com/missingcharacter/asdf-kotlin.git &&
asdf plugin-add redis https://github.com/smashedtoatoms/asdf-redis.git &&
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git &&
asdf plugin-add sqlite https://github.com/cLupus/asdf-sqlite.git &&
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git &&
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring &&
asdf install nodejs 14.0.0 &&
asdf global nodejs 14.0.0 &&
asdf install postgres 12.1 &&
asdf global postgres 12.1 &&

# ----- dotnet core -----
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb &&
sudo dpkg -i packages-microsoft-prod.deb &&
sudo add-apt-repository universe &&
sudo apt-get update &&        
sudo apt-get install apt-transport-https &&
sudo apt-get update &&
sudo apt-get install dotnet-sdk-3.1 &&
sudo apt-get update &&
sudo apt-get install aspnetcore-runtime-3.1 &&
sudo aot-get update &&
sudo apt-get install dotnet-runtime-3.1 &&

# ----- outras configurações -----
git config --global credential.helper store &&
chmod +x fonts.sh &&
./fonts.sh &&
# > global menu
sudo apt update &&
sudo apt install xfce4-appmenu-plugin -y &&
xfconf-query -c xsettings -p /Gtk/ShellShowsMenubar -n -t bool -s true &&
xfconf-query -c xsettings -p /Gtk/ShellShowsAppmenu -n -t bool -s true &&

sudo apt update && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y &&

echo "Finalizado!";

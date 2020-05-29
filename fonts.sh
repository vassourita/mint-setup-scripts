# Original author: Michalis Georgiou 
# Modified by Andrew http://www.webupd8.org 
# Traduzido para português por Elias Praciano https://elias.praciano.com

_wgeturl="https://github.com/google/fonts/archive/master.tar.gz"
_gf="google-fonts"

# certifica que não há outro arquivo com o mesmo nome
rm -f $_gf.tar.gz

echo "Conectando ao servidor Github. Aguarde...."
wget $_wgeturl -O $_gf.tar.gz

echo "Extração do arquivo baixado..."
tar -xf $_gf.tar.gz

echo "Criação do diretório /usr/share/fonts/truetype/$_gf folder"
sudo mkdir -p /usr/share/fonts/truetype/$_gf

echo "Instalação das fontes .ttf em /usr/share/fonts/truetype/$_gf"
find $PWD/fonts-master/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1

echo "Atualização do cache de fontes..."
fc-cache -f > /dev/null

# Limpeza. Remove o arquivo .tar.gz. O usuário poderá ainda precisar da pasta
rm -f $_gf.tar.gz

echo "Pronto."

#!/bin/bash
# Openssl PKI Framework (C) 2020 version 1.2
# CA and SUb CA - EC prime256v1
# Full Setup sh - Debian. If your CA box is 
# CentOS or RHat just change package cmd to dnf or yum.
# Usar:chmod +x setup_pki.sh - sudo bash setup_pki.sh
#

set -e

function pause(){
   read -p "$*"
}

#check updates
#dnf clean all
#dnf -y update
#install tools
#dnf -y install chrony wget nano net-tools curl openssl
apt clean all
apt update -y && apt upgrade -y && apt autoremove -y
echo '""""""""""""""""""""""'
echo Install requisites
echo 
apt -y install chrony wget nano net-tools curl openssl
echo
#portuguese ntp pool
echo 'server 0.pt.pool.ntp.org' >> /etc/chrony.conf
systemctl restart chrony
systemctl enable chrony
chronyc sources
#apagar directorios se existirem.
rm -rf /root/CA/
rm -rf /root/subCA/
rm -rf /usr/bin/CA-*
echo
echo
echo '!----------------------------------------------------!'
echo '!                                                    !'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!                ROOT e SUB CA  SETUP                !'
echo '!                with EC prime256v1                  !'
echo '!----------------------------------------------------!'
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!                I. ROOT CA SETUP                    !'
echo '!----------------------------------------------------!'
echo
pause '  [ENTER] To Continue, [CTRL+C] To Cancel.'
echo
mkdir -p /root/CA/
cp cnf/rootCA.cnf /root/CA/
mkdir -p /root/CA/certs/
mkdir -p /root/CA/crl/
mkdir -p /root/CA/csr/
mkdir -p /root/CA/private/
mkdir -p /root/CA/newcerts/
chmod 700 /root/CA/private
touch /root/CA/index.txt
echo $(date +%Y%m%d%H%M)0001 > serial
mv serial /root/CA/
echo $(date +%Y%m%d%H%M)0001 > crlnumber
mv crlnumber /root/CA/
echo
echo 'Folders and Files List - ROOT CA /root/CA'
echo
ls -lha /root/CA/ --color=auto
echo
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!            II. ROOT CA CERT & KEY SETUP            !'
echo '!----------------------------------------------------!'
echo
pause ' [ENTER] To Continue.'
echo

openssl ecparam -genkey -name prime256v1 -out /root/CA/private/rootCA.key.pem
openssl req -config /root/CA/rootCA.cnf -new -key /root/CA/private/rootCA.key.pem -out /root/CA/csr/rootCA.csr.pem
openssl req -config /root/CA/rootCA.cnf -key /root/CA/private/rootCA.key.pem -new -x509 -sha256 -days 7300 -extensions v3_ca -out /root/CA/certs/rootCA.cert.pem
echo
openssl x509 -noout -text -in /root/CA/certs/rootCA.cert.pem
echo
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!    IIA -  ROOT CERTIFICATE SUCCESSFULLY CREATED    !'
echo '!----------------------------------------------------!'
echo
#pause ' [ENTER] To Continue.'
echo
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!     III - ARL/CRL ROOT CA SUCCESSFULLY CREATED     !'
echo '!----------------------------------------------------!'
echo
echo
openssl ca -config /root/CA/rootCA.cnf -gencrl -out  /root/CA/crl/rootCA.crl
echo
pause '[ENTER] to Continue to section IV - [ SUB CA CONFIG ]'
echo
echo
echo
echo
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!            IV. SUB CA CERT & KEY SETUP             !'
echo '!----------------------------------------------------!'
echo
echo
pause '[ENTER] To Continue, [CTRL+C] To Cancel.'
echo
mkdir -p /root/subCA/
mkdir -p /root/subCA/.cnf
cp cnf/CA*.sh /root/subCA/.cnf
cp cnf/subCA.cnf /root/subCA/
mkdir -p /root/subCA/certs/
mkdir -p /root/subCA/crl/
mkdir -p /root/subCA/csr/
mkdir -p /root/subCA/private/
mkdir -p /root/subCA/newcerts/
chmod 700 /root/subCA/private
touch /root/subCA/index.txt
echo $(date +%Y%m%d%H%M)0001 > serial
mv serial /root/subCA/
echo $(date +%Y%m%d%H%M)0001 > crlnumber
mv crlnumber /root/subCA/
echo
echo 'Foldes and Files List - SUB CA /root/subCA'
echo
ls -lha /root/subCA/ --color=auto
echo
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!            V. SUB CA CERT & KEY SETUP              !'
echo '!----------------------------------------------------!'
echo
echo
pause ' [ENTER] To Continue.'
echo

openssl ecparam -genkey -name  prime256v1  -out /root/subCA/private/subCA.key.pem
openssl req -config /root/subCA/subCA.cnf -new -key /root/subCA/private/subCA.key.pem -out /root/subCA/csr/subCA.csr.pem
openssl ca -config /root/CA/rootCA.cnf -extensions v3_sub_ca  \
      -days 3650 -notext -md sha256 \
      -in /root/subCA/csr/subCA.csr.pem \
      -out /root/subCA/certs/subCA.cert.pem
echo
echo
openssl x509 -noout -text -in /root/subCA/certs/subCA.cert.pem
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!         VI - SUB CA SUCCESSFULLY CREATED           !'
echo '!----------------------------------------------------!'
echo
pause '[ENTER] To Continue.'
echo
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!          VII - SUB-CA CHAIN SETUP - CRL            !'
echo '!----------------------------------------------------!'
echo
pause '[ENTER] To Continue.'
echo
cat /root/subCA/certs/subCA.cert.pem \
   /root/CA/certs/rootCA.cert.pem > /root/subCA/certs/ca-chain.cert.pem
echo
echo
echo
echo '!----------------------------------------------------!'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!     VIII - SUB-CA CHAIN SETUP - GENERATE CRL       !'
echo '!----------------------------------------------------!'
echo
echo '!----------------------------------------------------!'
echo '!                CA-CHAIN + CRL                      !'
echo '!----------------------------------------------------!'
echo
cat /root/subCA/certs/ca-chain.cert.pem
echo
pause '[ENTER] To Continue.'
openssl ca -config /root/CA/rootCA.cnf -gencrl -out  /root/CA/crl/rootCA.crl

##variaveis para o sistema
###criar atalhos para o sistema
SRC=/root/subCA/.cnf/
DEST=/usr/bin
for script in "$SRC"/CA*.sh; do
  base=${script##*/}; # prune path to sh
  ln -srf "$script" "$DEST/${base%*.sh}" # e.g. /usr/bin/CA-name-of-script -> $SRC/CA-name-of-script.sh
done
echo
echo '!----------------------------------------------------!'
echo '!                                                    !'
echo '!         OPENSSL PKI FRAMEWORK v1.2 SETUP           !'
echo '!                                                    !'
echo '!        IX - SETUP SUCCESSFULLY COMPLETED           !'
echo '!                  @paciente23256                    !'
echo '!                                                    !'
echo '!----------------------------------------------------!'
echo
pause ' [ENTER] To Close.'
echo



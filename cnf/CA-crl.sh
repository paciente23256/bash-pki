#!/bin/bash
#Openssl PKI 2020 vs1.2
#CRL

set -e

function pause(){
   read -p "$*"
}

echo '!-----------------------------------------!'
echo '!   PKI - GERAL E PUBLICAR CRL SUB CA     !'
echo '!-----------------------------------------!'
echo
openssl ca -config /root/subCA/subCA.cnf -gencrl -out /root/subCA/crl/subCA.crl.pem
echo
echo '!            --- CRL OK ---               !'
echo
echo
echo '!          --- A PUBLICAR ---             !'
echo
echo
scp /root/subCA/crl/subCA.crl.pem root@crl.dns.priv:/var/www/html/subCA.crl
echo
echo
echo '!-----------------------------------------!'
echo '!         CRL  CONCLUIDA COM EXITO        !'
echo '!-----------------------------------------!'
echo
pause ' [ENTER] To Close.'
echo

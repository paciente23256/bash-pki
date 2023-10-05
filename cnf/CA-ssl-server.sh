#!/bin/bash

#Openssl PKI 2020 vs1.2
#SSL Server


set -e
PDIR=$(pwd)
rootca='/root/subCA/'
cd $rootca


function pause(){
   read -p "$*"
}

#Required
domain=$1
commonname=$domain


if [ -z $domain ]

then


echo
echo '!-----------------------------------------------------!'
echo ' -> DEVE APRESENTAR UM NOME VALIDO DE DOMINIO '
echo ' -> por ex. '$0' [www.bestorg.pt]'
echo '!-----------------------------------------------------!'

    exit 1

elif [ -e certs/$domain.cert.pem ]

then


echo
echo '!-----------------------------------------------------------!'
echo ' -> O CERTIFICADO PARA O DOMÍNIO:[ '$domain' ] JÁ EXISTE.'
echo ' -> DEVE REVOGAR ESTE CERTIFICADO PRIMEIRO.'
echo ' -> por ex. CA-ssl-revoke [ '$domain' ]'
echo '!-----------------------------------------------------------!'
echo
        exit 1
fi
echo
echo '!-----------------------------------------!'
echo '   -> NOVO CERTIFICADO SRV :'$domain
echo '!-----------------------------------------!'
echo
#criar chave priv -key
openssl ecparam -genkey -name prime256v1 -out private/$domain.key.pem
#criar pedido - csr
openssl req -config subCA.cnf -new -key private/$domain.key.pem -out csr/$domain.csr.pem
#assinar pedido - crt
openssl ca -config subCA.cnf -extensions server_cert -days 375 -notext -md sha256 -in  csr/$domain.csr.pem -out certs/$domain.cert.pem
#geral crl - crl
openssl ca -config subCA.cnf -gencrl -out crl/subCA.crl.pem
echo
echo
#certificado
cat /root/subCA/certs/$domain.cert.pem
echo
echo
#chave privada
cat /root/subCA/private/$domain.key.pem
echo
echo
echo
echo '!-----------------------------------------!'
echo '!     CERTIFICADO CRIADO COM EXITO        !'
echo '!-----------------------------------------!'
echo
echo
echo
pause ' [ENTER] PARA SAIR.'
echo


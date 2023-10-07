#!/bin/bash
#Openssl PKI (r) 2020 vs1.2
#SSL User CERT

set -e
PDIR=$(pwd)
rootca='/root/subCA/'
cd $rootca

function pause(){
   read -p "$*"
}

#Required
user_cert=$1
commonname=$user_cert


if [ -z $user_cert ]

then
    echo '--!'
        echo '--> DEVE APRESENTAR UM UTILIZADOR VALIDO.'
    echo '--> POR ex. ./ssl_server_cert.sh [player@bdns.priv]'

    exit 1

elif [ -e certs/$user_cert.cert.pem ]

then
    echo '--!'
        echo '--> O CERTIFICADO PARA O UTILIZADOR:[ '$user_cert' ] JÁ EXISTE, DEVE REVOGAR ESTE CERTIFICADO PRIMEIRO.'
echo ' POR EX.  openssl ca -config /root/subCA/subCA.cnf -revoke /root/subCA/certs/'$user_cert'.cert.pem'
        exit 1
fi

echo
echo
echo '!-----------------------------------------!'
echo '   -> NOVO CERTIFICADO SRV :'$user_cert
echo '!-----------------------------------------!'
echo
echo
#criar chave priv -key
openssl ecparam -genkey -name prime256v1 -out private/$user_cert.key.pem
#criar pedido - csr
openssl req -config subCA.cnf -new -key private/$user_cert.key.pem -out csr/$user_cert.csr.pem
#assinar pedido - crt
openssl ca -config subCA.cnf -extensions usr_cert -days 375 -notext -md sha256 -in  csr/$user_cert.csr.pem -out certs/$user_cert.cert.pem
#geral crl - crl
openssl ca -config subCA.cnf -gencrl -out crl/subCA.crl.pem
echo
echo
#certificado
echo 'CERTIFICADO'
cat /root/subCA/certs/$user_cert.cert.pem
echo
echo
#chave privada
echo 'CHAVE PRIVADA'
cat /root/subCA/private/$user_cert.key.pem
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


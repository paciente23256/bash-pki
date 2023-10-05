#!/bin/bash
#Openssl PKI (r) 2020 vs1.2
#SSL Revoke

set -e
PDIR=$(pwd)
rootca="/root/subCA/"
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
echo '!-----------------------------------------!'
echo '!       PKI - REVOGAR CERTIFICADO SSL     !'
echo '!-----------------------------------------!'
echo
echo
    echo 'Deve apresentar um dominio válido'
    echo 'Por ex. '$0' [Nome do dominio]'
    echo
    exit 1
fi


echo
echo '!-----------------------------------------!'
echo '!---> REVOGAR O CERTIFICADO :'$domain'<---'
echo '!-----------------------------------------!'
echo
echo
pause '[ENTER] PARA CONTINUAR.'
echo
openssl ca -config subCA.cnf -revoke certs/$domain.cert.pem
echo
#apagar relacoes com o certificado
rm -rf certs/$domain.cert.pem
rm -rf private/$domain.key.pem
rm -rf csr/$domain.csr.pem
#geral crl
openssl ca -config subCA.cnf -gencrl -out crl/subCA.crl.pem
echo
echo '!-----------------CRL OK-------------------!'
echo
echo
echo '!------- CERTIFICADOS VALIDOS -------------!'
ls -lha certs/
echo
echo '!-----------------------------------------!'
echo '!     CERTIFICADO REVOGADO COM EXITO      !'
echo '!-----------------------------------------!'
echo

pause ' [ENTER] PARA SAIR.'
echo


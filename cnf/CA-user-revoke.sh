#!/bin/bash
#Openssl PKI 2020 vs1.2
#SSL User Revoke

set -e
PDIR=$(pwd)
rootca="/root/subCA/"
cd $rootca


function pause(){
   read -p "$*"
}

#Required
user_cert=$1
commonname=$user_cert
if [ -z $user_cert ]

then
echo
echo '!-----------------------------------------!'
echo '!  PKI - REVOGAR CERTIFICADO - UTILIZADOR !'
echo '!-----------------------------------------!'
echo
echo
    echo 'Deve apresentar um utilizador válido'
    echo 'Por ex. '$0' [nome do utilizador]'
    echo
    exit 1
fi


echo
echo '!-----------------------------------------!'
echo '!---> REVOGAR O CERTIFICADO :'$user_cert
echo '!-----------------------------------------!'
echo
echo
pause '[ENTER] PARA CONTINUAR.'
echo
openssl ca -config subCA.cnf -revoke certs/$user_cert.cert.pem
echo
#apagar relacoes com o certificado
rm -rf certs/$user_cert.cert.pem
rm -rf private/$user_cert.key.pem
rm -rf csr/$user_cert.csr.pem
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
echo
pause ' [ENTER] PARA SAIR.'
echo


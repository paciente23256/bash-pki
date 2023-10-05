
#!/bin/sh
#Openssl PKI (C) 2020 vs1.2
#Menu
echo
echo '!---------------------------------------------------------!'
echo '!   OPENSSL PKI v1.2 - AJUDA - COMANDOS                   !'
echo '!---------------------------------------------------------!'
echo
echo '    COMANDOS DIPONIVEIS:'
#auto extract from bin
#find /usr/bin -name 'CA-*' -exec basename {} \;
echo
echo ' CA -h             MENU AJUDA'
echo ' CA-Backup         FAZ BACKUP TOTAL PASTA /ROOT/*'
echo ' CA-crl            GERA E PUBLICA A CRL'
echo ' CA-ssl-server     CRIA CERTIFICADOS SSL DE SERVIDOR'
echo ' CA-ssl-revoke     REVOGA CERTIFICADOS SSL DE SERVIDOR'
echo ' CA-user           CRIA CERTIFICADOS SSL DE UTILIZADOR'
echo ' CA-user-revoke    REVOGA CERTIFICADOS SSL DE UTILIZADOR'
echo
echo '    Usar: CA-ssl-server [nome do dominio]'
echo
echo '!---------------------------------------------------------!'
echo

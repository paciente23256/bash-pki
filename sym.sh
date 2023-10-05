#!/bin/bash
# Openssl PKI 2020 vs1.2
# symlink menu | binary menu links

cp cnf/CA.sh /usr/bin/ca
cp cnf/CA-backup.sh /usr/bin/ca-backup
cp cnf/CA-crl.sh /usr/bin/ca-crl
cp cnf/CA-ssl-server.sh /usr/bin/ca-ssl-server
cp cnf/CA-ssl-revoke.sh /usr/bin/ca-ssl-revoke
cp cnf/CA-user.sh /usr/bin/ca-user
cp cnf/CA-user-revoke.sh /usr/bin/ca-user-revoke
chmod +x /usr/bin/ca*

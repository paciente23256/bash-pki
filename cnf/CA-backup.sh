#!/bin/bash
#Openssl PKI 2020 vs1.2
#BackupAll

set -e

function pause(){
   read -p "$*"

   }
echo '!-----------------------------------------!'
echo '!   PKI - FOLDER FULL BACKUP  /root/*     !'
echo '!-----------------------------------------!'

echo
#Full Backup SubCA
tar fcz /root/backups/Full_backup_subCA$(date +%Y%m%d%H%M).tar.gz --absolute-names /root/subCA /root/*.sh
echo
echo

ls -la /root/backups/*.gz
echo
echo
#Full Backup CA
#tar fcz /root/backups/Full_backup_CA$(date +%Y%m%d%H%M).tar.gz --absolute-names /root/CA

echo '!-----------------------------------------!'
echo '!       BACKUP CONCLUIDO COM EXITO        !'
echo '!-----------------------------------------!'
echo
echo '!-----------------------------------------!'
echo '!      Openssl PKI by @paciente23256      !'
echo '!-----------------------------------------!'
echo
pause ' [ENTER] To Close.'
echo

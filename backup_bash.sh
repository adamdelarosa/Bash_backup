#!/bin/bash
######################################################
# This script was made by the amaizing Adam Delarosa #
#    You may use it to backup other servers          #
#         this script will mount,tar and             #
#              export your stuff to                  #
#               a windows network                    #
#                      folder                        #   
######################################################



backup_files="/var/lib/back"  #CHANGE THIS to the file/folder need to back up
dest="/mnt/smb"  				 #CHANGE THIS and or make dir in /mnt/

day=$(date +%Y-%m-%d____%H_%M_%S)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

echo "_____________________________________" >> /var/log/back-backup-script/back-backup  #CHANGE THIS for log
date  >> /var/log/back-backup-script/backup  #CHANGE THIS for log
echo " " >> /var/log/back-backup-script/back-backup  #CHANGE THIS for log
echo "***  back backup is starting!  ***" >> /var/log/back-backup-script/back-backup #CHANGE THIS for log

clear
echo "____________________________________________________________________"
echo " "
echo " "
echo "***  back backup is starting!  ***"
echo " "
echo " "
echo "____________________________________________________________________"
echo " "
echo " "
umount /mnt/smb >> /var/log/back-backup-script/back-backup #CHANGE THIS for log
echo " "
echo " "
echo "____________________________________________________________________"
sleep 0.2
echo  Unmounting the windows folder, please wait...
echo -ne '#                          (3%)\r'
sleep 0.2
echo -ne '#####                     (23%)\r'
sleep 0.2
echo -ne '#########                 (45%)\r'
sleep 0.2
echo -ne '###########               (51%)\r'
sleep 0.2
echo -ne '#############             (67%)\r'
sleep 0.2
echo -ne '###############           (85%)\r'
sleep 0.2
echo -ne '###################       (96%)\r'
sleep 0.2
echo -ne '#######################  (100%)\r'
echo -ne '\n'
echo "____________________________________________________________________"
sudo mount -t cifs //xxx.xxx.xxx.xxx/"MAKE DIR IN WINDOWS"/ -o username=xxx,password=xxxxxx /mnt/smb  >> /var/log/back-backup-script/back-backup #CHANGE THIS for log
echo Mounting the windows folder, please wait...  >> /var/log/back-backup-script/back-backup #CHANGE THIS for log
echo -ne '#                          (1%)\r'
sleep 0.2
echo -ne '#####                     (22%)\r'
sleep 0.2
echo -ne '#########                 (45%)\r'
sleep 0.2
echo -ne '###########               (51%)\r'
sleep 0.2
echo -ne '#############             (67%)\r'
sleep 0.2
echo -ne '###############           (85%)\r'
sleep 0.2
echo -ne '###################       (96%)\r'
sleep 0.2
echo -ne '#######################  (100%)\r'
echo -ne '\n'
echo "____________________________________________________________________"
echo " "
echo BACKUP STATUS:
echo " "
ls -la  /mnt/smb
echo " "
echo "____________________________________________________________________"
echo " "
echo "Backing up from : $backup_files to $dest/$archive_file" >> /var/log/back-backup-script/back-backup #CHANGE THIS for log
echo "Backing up from : $backup_files to $dest/$archive_file"
echo " "
echo "____________________________________________________________________"
echo " "
echo "             BACKUP IN PROGRESS,  DO NOT TOUCH OR CANCEL!           "
echo " "
echo "Backup start at: $(date)"
echo " "
tar zcvf $dest/$archive_file $backup_files -k  --totals 
echo " "
echo "             BACKUP IN PROGRESS,  DO NOT TOUCH OR CANCEL!           "
echo " "
echo "____________________________________________________________________"
echo " "
echo "Compression completed successfully."
echo " "
echo "____________________________________________________________________"
echo "Checking now for new existing backup: $dest/$archive_file"
echo " "
echo "____________________________________________________________________"
echo " "
if [ -e "$dest/$archive_file" ]; then
    echo $dest/$archive_file - Has been successfully transferred, backup is OK.
else
    echo $dest/$archive_file - is not exists, FAILED.
    mail -s "testmail" xxx@xxx.com "Backup to jenkines has started and end with error: 

$dest/$archive_file - is not exists, FAILED.

this is a automatic mail that sent by root,xxx.xxx.xxx.xxx ."

fi
echo " "
echo "Removing files that are more then 7 days..."

find /mnt/smb/* -mtime +4 -delete  #CHANGE THIS and or make dir in /mnt/ also can change days for delete old backups.
echo " "
OUTPUT="$(ls -1)"
echo "Done."

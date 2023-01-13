@ECHO OFF

SET MY_STATUS=helloworld
SET MY=VIENT

SET TOUT=%MY_STATUS% AND %MY%

ECHO %TOUT%
REM echo %MY_STATUS% %date% %time%



PAUSE

REM https://linuxize.com/post/how-to-mount-cifs-windows-share-on-linux/
REM mount a share folder
REM bat
 NET USE E: \\sql-backups.rms-asp.com\backup /u:domain\user_name my_password /persistent:yes
 REM NET USE E: /delete
REM bash, ubuntu on temp mounted
sudo mount -t cifs -o username=mbello@rms-asp.com //ipaddress/share_nmae /home/mbello/shared/new3
 

REM copy over with exclude list in file
XCOPY  G:  E:  /EXCLUDE:S:\DIFF_exclusion.txt  /c/d/i/s/e/y >> copy_backup_DIFF.log
REM exclude list like
.trn
FULL

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
REM bash, ubuntu on temp mounted
sudo mount -t cifs -o username=mbello@rms-asp.com //ipaddress/share_nmae /home/mbello/shared/new3
 

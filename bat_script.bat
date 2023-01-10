@ECHO OFF

SET MY_STATUS=helloworld
SET MY=VIENT

SET TOUT=%MY_STATUS% AND %MY%

ECHO %TOUT%
REM echo %MY_STATUS% %date% %time%



PAUSE

REM mount a share folder
 NET USE E: \\sql-backups.rms-asp.com\backup /u:domain\user_name my_password /persistent:yes

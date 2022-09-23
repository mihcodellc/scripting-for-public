##run with win authentifcation instead remote to server to login in
runas.exe /noprofile /netonly /user:rms-asp\mbello "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.exe"

## https://www.shellhacks.com/windows-cmd-path-variable-add-to-path-echo-path/
## read win path
C:\> echo %PATH:;=&echo.%
## save path
C:\> echo %PATH% > C:\path-backup.txt


## add to path temp
C:\> set PATH="%PATH%;C:\path\to\directory\"
--add to path permanently
C:\> setx path "%PATH%;C:\path\to\directory\"


## add  to powershell path
$Env:PSModulePath = $Env:PSModulePath+";S:\DBA\dbatools"
$cred = Get-Credential mydomain\mbello
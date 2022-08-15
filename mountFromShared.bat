 REM mount a drive 
 NET USE X: \\shared_folder_on_remote /user:<user_login>  <user_apssword>
 
REM unlink mounted drive
NET USE X: /delete

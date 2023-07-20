--Linux Command Cheat Sheet
#https://www.guru99.com/linux-commands-cheat-sheet.html#:~:text=%20%20%20%20Command%20%20%20,with%20detaile%20...%20%2025%20more%20rows%20
#https://tldp.org/LDP/Bash-Beginners-Guide/html/

#server name
nslookup ipaddress

# listen port
sudo netstat -tulpn | grep LISTEN

#ip address eq of ipconfig 
ifconfig -a

#use help in command ligne: 
#   man [option].. [command name]..
#    man -k [key_word] # relevant
#    man -a [key_word] # all mathcing 
# https://www.tutorialkart.com/bash-shell-scripting/bash-current-date-and-time/
# https://linuxgazette.net/18/bash.html
#https://doc.ubuntu-fr.org/tutoriel/learn_unix_in_10_minutes
#https://www.gnu.org/software/bash/manual/bash.html#Looping-Constructs
#https://linux.die.net/man/1/bash
#https://www.guru99.com/linux-commands-cheat-sheet.html#:~:text=%20%20%20%20Command%20%20%20,with%20detaile%20...%20%2025%20more%20rows%20

mkdir dossierbello
cat > jecreeunfichier_executable_pour_bash.sh
#en commentaire : save ici ie ctrl+d
cp file1 copie_de_file1 # -r pour un dossier
mv file1 est_copie_de_file1
rm supprime_ce_fichier
chmod u+rwx permis_user_sur_file1
ls -l #permission sur les objets
bash execute_cefichier.sh
chown monktar_ownerde file1 # -R 


#https://www.sitepoint.com/cron-jobs/
# https://linuxhandbook.com/crontab/
# postgres login auth psql-error-fix.md on git at https://gist.github.com/mihcodellc/cdfb22b14e6ae77f9335005a8e926681
sudo su - <exec as user name>
# #cd - cd.. - cd ~ - pwd


# https://linuxize.com/post/how-to-mount-cifs-windows-share-on-linux/
# mount a share folder
# bat
 NET USE E: \\mitiristore\backup /u:domain\user_name my_password /persistent:yes
# bash, ubuntu on temp mounted or Use WinSCP or FileZilla
sudo mount -t cifs -o username=mbello@mih.com //ipaddress/share_nmae /home/mbello/shared/new3

#attach  the filesystem found on device (which is of type type) at the directory dir
mount -t type device dir #

#lists all mounted filesystems --  robust and customizable output use findmnt(8)
findmnt -t cifs,nfs #-t <type> : filters the output by filesystem "cifs`" & nfs
mount -l
mount -l -t cifs #-t <type> : filters the output by filesystem "cifs`"

echo "Enter the full path to the file."
read file
filesize=$(ls -lh $file | awk '{print  $5}')
echo "$file has a size of $filesize"


# Files here Directories further down
# size with h after -l ie h = human-readable
# WITHOUT h the value is express in bytes 1MB = 1,048,576 Bytes 
# https://www.gbmb.org/mb-to-bytes
# https://linuxhint.com/what-does-ls-l-command-do-in-linux/
# -F “/” after the name of a directory
# -r sort the output in reverse order
# -t sort the files and directories by time and date
# -a show the hidden files
# -d list directories themselves, not their contents
# -1 (The numeric digit “one”.) Force output to be one entry per line. 
# combine with | head -10 => to list top 10
ls -lth *Archive*.bak # files
ls -lth LOGSHIPPING_COPY | tail -15   # files in folder named LOGSHIPPING_COPY

# https://linuxhandbook.com/sort-command/
#sort the content of a file
sort filename.txt
#sort by  by the numerals on the third column
sort filename.txt -k 3n 
     1. MX Linux 100
     5. Ubuntu 200
     3. Mint 300
     2. Manjaro 400
     4. elementary 500
#------------------------------------------------------------------------
#copie between server to your /home/mbello. To just the directory:  cd $HOME OR cd ~ <> cd - => revient au dossier précédent
scp ./fileName mbello@serverName:~ 

signa=$(find .  -type f -name "ready_for_short_term_FULL.txt" | head -n 1)

#How to Find Length of String in Bash Script?
#https://www.geeksforgeeks.org/how-to-find-length-of-string-in-bash-script/
 signa=$(find .  -type f -name "ready_for_short_term_*.txt" | head -n 1)
        lg=${#signa}
        echo "length is $lg "
        #can we process ?
        if [ $lg == 0 ]; then
                exit 1 # nothing happens
        fi



#count files+directories without hidden files
ls | wc -l
find . -type f | wc -l # only files
find . -maxdepth 1 -type f | wc -l # files in current directories

#read mail folder
cat <mail_folder>
#purge mail folder
> <mail_folder>


#https://www.sitepoint.com/cron-jobs/
# 2>&1 ie both standard output and error output AND /dev/null ie noemail to the owner of this crontab
# the script does send email to dba. every 20min. the log backup happen every 15min. a "done" file control when to move file
# min hour dom moy dow **** /20 ie every. you can list all values 1-5 or 1,2,3,4,5
*/20 * * * * /home/rms-svc/scripts/move_sql002_backup.sh >/dev/null 2>&1

#redirect combine append to other file
 #/dev/null, or the bit bucket, is used as a garbage can for the command line. Unwanted output can be redirected to this location to simply make it disappear.
./file.sh > nouveau_fichier # a chaque fois
./file.sh >> fichier_existant # à la fin du fichier fichier_existant
./file.sh 2> nouveau_fichier #The stderr operator is 2> (for file descriptor 2). error only
./file.sh 1> nouveau_fichier #The stdout operator is 1> (for file descriptor 1). error only

# https://tecadmin.net/crontab-in-linux-with-20-examples-of-cron-schedule/#:~:text=20%20Useful%20Examples%20for%20Scheduling%20Crontab%201%20Schedule,to%20execute%20on%20selected%20months.%20...%20More%20items
#edit the crontab -e  -- in nano ctrl+x (exit) + Y/N + Enter  OR ctrl+O (write)
# <Minute> <Hour> <Day_of_the_Month> <Month_of_the_Year> <Day_of_the_Week> <command>
# min hour dom moy dow **** /20 ie every. you can list all values 1-5 or 1,2,3,4
# m h  dom mon dow   command
# 2>&1 ie both standard output and error output AND /dev/null ie noemail to the owner of this crontab
# */20 * * * * /home/mbello/test.sh >/home/mbello/log # every 20 minutes
# */20 * * * * /home/mbello/test.sh >/dev/null 2>&1

crontab -e 


# read crontab content
crontab -l

# execute test.sh
./test.sh
clear

# read last 50 lines of log files
tail -n 50 log
exit


#size of folder
df #disk space usage files/ directories
du -sh folderPath
du -sm * | sort -nr | head -15 #each directory summarized -c for MB -n numeric -r reverse
du -hc # each subdirectory -c total line at the end
#find all files with the pattern and sum size in column5 /1024/2024 = 1048576 > size in MB
find -ipath '*DB_name_*.trn' -mtime -2 -exec ls -l "{}" \; | awk '{ sum += $5/1048576 } END{ print sum }'

#remove
rm  -fv  *abc*202207*.trn # rm -r directory
find -ipath '*.trn' -mtime +10 -delete


 #-size n => n in b,k,M, G ...bibytes
 #-atime n => File was last accessed n*24 hours ago
 #-cmin n  => File's status was last changed n minutes ago
 #-mmin n  => File's data was last modified n minutes ago
 #-mtime n => File's data was last modified n*24 hours ago
 #-empty   => File is empty and is either a regular file or a directory
 #-executable => Matches  files  which  are executable and directories which are searchable
 #-exec command => Execute  command;  true  if 0 status is returned.
 #-regex pattern =>  File name matches regular expression pattern.  This is a match on the whole path
 #return/search file *.trn last modified a day ago order by time
find -name *.trn -mtime +1 -exec ls -lth "{}" \; # n = exact -n = less than +n = greater than
find -name '*.*'  -mtime +60  -exec ls {} \;  | sort # backup more than 60

#find directories
sudo find -mindepth 1 -maxdepth 3 -type d -ipath '*postgres*'


#find search  in file
cat pattern1*.csv pattern2*.csv | grep -i "search_text" > /tmp/db3018.log
#better use cat is to display 
cat $(find . -name aaa.txt) | grep -i "search_text" > /tmp/db3018.log
#use find grep + regex regular expressiion -E #https://phoenixnap.com/kb/grep-regex
cat $(find . -name "*2023*.csv") | grep -i -E 'update.*?deleted' >  /tmp/bello03142023.txt



#The lsof command returns the process name, the PID, and the user who is running the process: who is using the file
$ lsof | { head -1 ; grep text.txt ; }
COMMAND     PID   TID TASKCMD               USER   FD      TYPE             DEVICE  SIZE/OFF       NODE NAME
less      28423                            john     4r      REG                8,3        75    3146117 /home/john/text.txt

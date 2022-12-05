--Linux Command Cheat Sheet
#https://www.guru99.com/linux-commands-cheat-sheet.html#:~:text=%20%20%20%20Command%20%20%20,with%20detaile%20...%20%2025%20more%20rows%20

#use help in command ligne: 
#   man [option].. [command name]..
#    man -k [key_word] # relevant
#    man -a [key_word] # all mathcing 
# https://www.tutorialkart.com/bash-shell-scripting/bash-current-date-and-time/
# https://linuxgazette.net/18/bash.html
#https://doc.ubuntu-fr.org/tutoriel/learn_unix_in_10_minutes
#https://www.gnu.org/software/bash/manual/bash.html#Looping-Constructs
#https://linux.die.net/man/1/bash

#https://www.sitepoint.com/cron-jobs/
# https://linuxhandbook.com/crontab/
# postgres login auth psql-error-fix.md on git at https://gist.github.com/mihcodellc/cdfb22b14e6ae77f9335005a8e926681
sudo su - <exec as user name>

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
# combine with | head -10 => to list top 10
ls -lth *Archive*.bak # files
ls -lth LOGSHIPPING_COPY | tail -15   # files in folder named LOGSHIPPING_COPY

#count files+directories without hidden files
ls | wc -l
find . -type f | wc -l # only files
find . -maxdepth 1 -type f | wc -l # files in current directories

#read mail folder
cat <mail_folder>
#purge mail folder
> <mail_folder>



# https://tecadmin.net/crontab-in-linux-with-20-examples-of-cron-schedule/#:~:text=20%20Useful%20Examples%20for%20Scheduling%20Crontab%201%20Schedule,to%20execute%20on%20selected%20months.%20...%20More%20items
#edit the crontab -e  -- in nano ctrl+x (exit) + Y/N + Enter  OR ctrl+O (write)
# m h  dom mon dow   command
# */20 * * * * /home/mbello/test.sh >/home/mbello/log # every 20 minutes
crontab -e 


# read crontab content
crontab -l

# execute test.sh
./test.sh
clear

# read last 50 lines of log files
tail -n 50 log
exit

#disk space usage files/ directories
df #du

#size of folder
du -sh folderPath
du -sm * | sort -nr | head -15 #each directory

#remove
rm  -fv  *abc*202207*.trn # rm -r directory

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

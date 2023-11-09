--Linux Command Cheat Sheet
#https://www.guru99.com/linux-commands-cheat-sheet.html#:~:text=%20%20%20%20Command%20%20%20,with%20detaile%20...%20%2025%20more%20rows%20
#https://tldp.org/LDP/Bash-Beginners-Guide/html/


--memory cpu, ....
--https://vitux.com/how-to-use-htop-to-monitor-system-processes-in-ubuntu-20-04/
F6 : To sort the displaying output. once done esc to return to normal
F5: To display this relationship in a tree-like structure.exit with F5 one more time
F3: to search for a specific process and type the name of the search process in the search prompt that displays at the bottom of the terminal window
F4: to filter process and type the name of the search process in the search prompt that displays at the bottom of the terminal window	
htop -u mbello -- or F4
htop -p 70 #-p ie pid -- or F4
htop -s CPU # sort -- or F6

#server name network
nslookup ipaddress
hostname #windows

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


##command subtitution
#1
number=5
squared=$(echo $((number * number)))
echo "The square of $number is $squared"
#2
original_file="myfile.txt"
backup_file="backup_$(date +%Y%m%d%H%M%S).txt"
cp "$original_file" "$backup_file"



##alias 
compgen -a # list all alias
alias tout="ls -lth /" # create alias name tout to list all elements in root order by  created time
alias tout # show the definition of "tout" or its meaning
compgen -a | alias # list meaning of each alias



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

#alternative at ls command stat: both list. stat more powerfull - %y timestamp %s size %n name  
find -ipath '*FULL_*.bak' -exec stat -c " %Y %y %s %n"  "{}" \; # %n voir complete list: man stat
find -ipath '*FULL_*.bak' -exec stat -c "%y %s %n"  "{}" \; | sort -k 1 | awk '{print $1}' # sort by first column, print first column
#1 return the date of oldest back file
echo $(find -ipath '*FULL_*.bak' -exec stat -c "%y %s %n"  "{}" \; | sort -k 1 | head -n 1 | awk '{print $1}') # return the date of oldest back file
#2 file  modified at date the "!" ie f false check next condition
find . -type f -newermt 2023-08-18 ! -newermt 2023-08-19
# 1 & 2 above lead to 


##play with date
echo $(date +%m-%d-%Y -d "2023-10-12 +1 days") # +%m is the format to apply for the output

# https://linuxhandbook.com/sort-command/
# sort lines of text files;  With no FILE, or when FILE is -, READ STANDARD INPUT why it can be it can used in pipeline to ls
sort filename.txt
# -k F.C [F,C] 
#     where F is a field number and C a character position in the field; both are origin 1, and the stop position defaults to the line's end
#sort by the numerals on the third column
sort filename.txt -k 3n 
     1. MX Linux 100
     5. Ubuntu 200
     3. Mint 300
     2. Manjaro 400
     4. elementary 500
ls -l | sort -k 2.3 # sort on 2nd column then 3rd character of this column

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

#count lines
wc -l <file_name>
grep -c '^' <file_name>



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

#run sql within bash file named myscript.sh
scripts=/var/lib/postgresql/scripts/
myscript=db3360
sqlfile=$myscript.sql
outfile=$myscript.out
logfile=$myscript.log

echo "START `date`" > $logfile

psql prod1 -f $sqlfile  -o $outfile

#Run or execute the script in background mode so it does not abort when your session dies:
nohup ./myscript.sh &

# execute test.sh
./test.sh
clear

# read last 50 lines of log files
tail -n 50 log
exit


#size of folder, remember to add folderpath if you need just one
df or df -h #disk space usage files/ directories -h human read
df folderpath # current directory
du -sh folderPath  # currrent folder size
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
#better use cat is to display for any file ie group matching search string
cat $(find . -name aaa.txt) | grep -i "search_text" > /tmp/db3018.log
#use find grep + regex regular expressiion -E #https://phoenixnap.com/kb/grep-regex
cat $(find . -name "*2023*.csv") | grep -i -E 'update.*?deleted' >  /tmp/bello03142023.txt
# searching multiple patterns error or fatal or warn in a file 
tail -f XYZ.csv | grep -i "error\|fatal\|warn"   
# search for the words extra and value in the sample.txt file
# https://phoenixnap.com/kb/grep-multiple-strings
grep -i  'extra\|value' sample.txt

#The lsof command returns the process name, the PID, and the user who is running the process: who is using the file
$ lsof | { head -1 ; grep text.txt ; }
COMMAND     PID   TID TASKCMD               USER   FD      TYPE             DEVICE  SIZE/OFF       NODE NAME
less      28423                            john     4r      REG                8,3        75    3146117 /home/john/text.txt



#function
# Define a function
my_function() {
    echo "This is my function!"
}
# Call the function
my_function

# You can also pass arguments to a function
another_function() {
    echo "Hello, $1!"
}

# Call the function with an argument
another_function "John"

#while with 2 conditions
while [ "$dest_size_avail" -gt "$total_size_tomove" ] && [ "$count" -gt 0 ]; do
    another_function # this is a function defined in previous lines
   	
	# Use the 'df' command to get disk space information
	df_output=$(df "$longdir")
	# Extract the available space from the 'df' command output - The 'tail -n 1' is used to get the last line (the current longdir)
	dest_size_avail=$(echo "$df_output" | tail -n 1 | awk '{print $4}')
	
done

# loop through file set in $list_file_todelete
 # Define the directory to search
directory="/mnt/c/users/mbello/Documents"
# Find the oldest creation date
oldest_date=$(find "$directory" -type f -exec stat --format=%Y {} \; | sort -n | head -n 1)
# Convert the oldest date to a human-readable format (e.g., YYYY-MM-DD)
oldest_date_readable=$(date -d "@$oldest_date" +'%Y-%m-%d')
# Delete files created on the oldest date
find "$directory" -type f -newermt "$oldest_date_readable" ! -newermt "$oldest_date_readable + 1 day" > $list_file_todelete
total_size_tomove=0
while IFS= read -r filename; do
    if [ -e "$filename" ]; then
        #rm "$filename"
        file_size=$(du -b $filename | awk '{print $1}')
        #size in bytes ie -b
        total=$((total + file_size))
        echo "Deleted: $filename $file_size "
    else
        echo "File not found: $filename"
    fi
done < "$list_file_todelete"

echo "Total size: $total found" 



#file exists using conditional statements
file_path="/path/to/your/file.txt"
if [ -f "$file_path" ]; then #  -f (checks for regular file existence) -e (checks for file or directory existence):
    echo "Regular file exists: $file_path"
else
    echo "File does not exist or is not a regular file: $file_path"
fi


echo "Enter the full path to the file."
read file
filesize=$(ls -lh $file | awk '{print  $5}')
echo "$file has a size of $filesize"

# size with h after -l
ls -lh *Archive*.bak

#read mail folder
cat <mail_folder>
#purge mail folder
> <mail_folder>


#
sudo su - <exec as user name>
#edit the crontab -e  -- in nano ctrl+x (exit)  OR ctrl+O (write)
# m h  dom mon dow   command
# */20 * * * * /home/mbello/test.sh >/home/mbello/log # every 20 minutes
crontab -e 



crontab -l
./test.sh
clear
tail -n 50 log
exit
df
du

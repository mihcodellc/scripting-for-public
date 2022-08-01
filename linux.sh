echo "Enter the full path to the file."
read file
filesize=$(ls -lh $file | awk '{print  $5}')
echo "$file has a size of $filesize"

# size with h after -l
ls -lh *Archive*.bak

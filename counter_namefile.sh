i=1
for f in NoName*.txt; do

   i=$(printf $i)   #zero-pad "$i", if wanted

   mv "$f" "${f/*/$i.txt}"  #replace the orginal file ending with "$i.pdf"
   let i++     #increment "$i" for the next file

done
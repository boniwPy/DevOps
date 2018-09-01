looping_bash.sh

#!/bin/bash

i=1
while [[ $n -le 10 ]]
do
php get30.php
i=`expr $i + 1`
done





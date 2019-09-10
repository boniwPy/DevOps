#/bin/bash
echo "MAU DIBUAT SWAP BERAPA GIGA MAS BOYSSSS followed by [ENTER]:=> dalam bentuk 4000kb = 4GB"
read size
sudo fallocate -l $size /swapfile 
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile 

/bin/dd if=/dev/zero of=/var/swap.1 bs=4M count=4028
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

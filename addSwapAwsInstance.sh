#/bin/bash
echo "MAU DIBUAT SWAP BERAPA GIGA MAS BOYSSSS followed by [ENTER]:=> "
read size
sudo fallocate -l $size /swapfile 
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile 

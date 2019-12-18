#/bin/bash
echo "Berama giga ukuran yang akan di jadikan swap ? EX:4G";
read sizeSwap
sudo dd if=/dev/zero of=/swapfile bs=$sizeSwap count=4
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
#vi /etc/fstab
echo " Harap tambahkan parameter ini agar swap otomatis nyala ketika restart add di /etc/fstab /swapfile swap swap defaults 0 0"

#!/bin/bash
date
sudo mv /etc/localtime /etc/localtime.bak
sudo ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
date

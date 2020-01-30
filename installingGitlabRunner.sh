#/bin/bash
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
# For Debian/Ubuntu/Mint
sudo apt-get install gitlab-runner
sudo gitlab-runner register

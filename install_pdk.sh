#!/bin/sh -f

## Installing docker
echo "## Installing docker"
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt-cache policy docker-ce
sudo apt install docker-ce
sudo usermod -aG docker ${USER}

echo "## Installing PDK."
cd
mkdir skywater
cd skywater
git clone https://github.com/google/skywater-pdk
cd skywater-pdk
git checkout v0.0.0-303-g3d7617a
git submodule init libraries/sky130_fd_io/latest
git submodule init libraries/sky130_fd_pr/latest
git submodule init libraries/sky130_fd_sc_hd/latest
git submodule init libraries/sky130_fd_sc_hdll/latest
git submodule init libraries/sky130_fd_sc_hs/latest
git submodule init libraries/sky130_fd_sc_ms/latest
git submodule init libraries/sky130_fd_sc_ls/latest
git submodule init libraries/sky130_fd_sc_lp/latest
git submodule init libraries/sky130_fd_sc_hvl/latest
git submodule update
make timing 

echo "## Installing Open PDK"
cd ~/skywater/
git clone https://github.com/RTimothyEdwards/open_pdks.git -b mpw-one-a
cd open_pdks
mkdir -p $HOME/skywater/pdk/skywater130
./configure --with-sky130-source=$HOME/skywater/skywater-pdk --with-sky130-local-path=$HOME/skywater/pdk/skywater130 --with-ef-style
cd sky130
make
make install
cd ~/skywater

echo "# Installing xschem sky130"
git clone https://github.com/StefanSchippers/xschem_sky130.git

echo "# Preparing tapeout folder."
cd
mkdir tapeout
git clone https://github.com/efabless/open_mpw_precheck
git clone https://github.com/efabless/openlane.git -b mpw-one-a
git clone https://github.com/efabless/caravel.git -b mpw-one-a caravel_$1


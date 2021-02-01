#!/bin/sh -f

mkdir temp
cd temp

export START_PWD=$PWD
echo "Installing dependencies."

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y vim htop git
sudo apt-get install -y build-essential htop
sudo apt-get install -y libtool automake autoconf flex bison texinfo
sudo apt-get install -y libx11-dev libxaw7-dev libreadline-dev
sudo apt-get install -y m4 vim tcl-dev tk-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev tcsh csh libx11-dev libcairo2-dev libncurses-dev
sudo apt-get install -y python3 python3-pip libgsl-dev libgtk-3-dev cmake
sudo apt-get install -y build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev

sudo apt-get install -y gengetopt help2man groff pod2pdf bison flex libhpdf-dev libtool autoconf octave liboctave-dev epstool transfig paraview
sudo apt-get install -y libhdf5-dev libvtk7-dev libboost-all-dev libcgal-dev libtinyxml-dev qtbase5-dev libvtk7-qt-dev
sudo apt-get install -y octave liboctave-dev
sudo apt-get install -y gengetopt help2man groff pod2pdf bison flex libhpdf-dev libtool
sudo apt-get install -y libopenmpi-dev
sudo apt install -y xterm graphicsmagick ghostscript
sudo apt install -y libtinyxml-dev libhdf5-serial-dev libcgal-dev vtk6 libvtk6-qt-dev
sudo apt install -y cython3 build-essential cython3 python3-numpy python3-matplotlib
sudo apt install -y python3-scipy python3-h5py


echo "## Installing tools"
echo "# Installing ngspice"
wget -O ngspice-34.tar.gz https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/34/ngspice-34.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fngspice%2Ffiles%2Fng-spice-rework%2F34%2Fngspice-34.tar.gz%2Fdownload&ts=1612217502
tar zxvf ngspice-34.tar.gz
cd ngspice-33
mkdir release
cd release
../configure --with-x --enable-xspice --enable-cider --enable-openmp --with-readlines=yes --disable-debug
make
sudo make install
cd $START_PWD

cd ngspice-34
mkdir build-lib
cd build-lib
../configure --with-x --enable-xspice --enable-cider --enable-openmp --disable-debug --with-ngshared
make
sudo make install
cd $START_PWD

echo "# Installing ngspice complete."
echo "# Installing magic"
wget http://opencircuitdesign.com/magic/archive/magic-8.3.122.tgz
tar zxvf magic-8.3.122.tgz
cd magic-8.3.122
./configure
make
sudo make install
cd $START_PWD

echo "# Installing klayout"
wget https://www.klayout.org/downloads/Ubuntu-20/klayout_0.26.8-1_amd64.deb
sudo dpkg -i ./klayout_0.26.8-1_amd64.deb
sudo apt-get install -f -y

echo "# Installing netgen"
wget http://opencircuitdesign.com/netgen/archive/netgen-1.5.165.tgz
tar zxvf netgen-1.5.165.tgz
cd netgen-1.5.165
./configure
make
sudo make install
cd $START_PWD

echo "# Installing xcircuit"
wget http://opencircuitdesign.com/xcircuit/archive/xcircuit-3.10.30.tgz
tar zxvf xcircuit-3.10.30.tgz
cd xcircuit-3.10.30
./configure && make && sudo make install
cd $START_PWD

echo "# Install Yoss"
git clone https://github.com/YosysHQ/yosys.git
cd yosys
make config-gcc
make
sudo make install
cd $START_PWD

echo "# Install graywolf"
git clone https://github.com/rubund/graywolf.git
cd graywolf
mkdir build
cd build
cmake ..
make
sudo make install
cd $START_PWD

echo "# Installing qrouter"
wget http://opencircuitdesign.com/qrouter/archive/qrouter-1.4.83.tgz
tar zxvf qrouter-1.4.83.tgz
cd qrouter-1.4.83
./configure
make
sudo make install


echo "# Installing qflow"
wget http://opencircuitdesign.com/qflow/archive/qflow-1.4.90.tgz
tar zxvf qflow-1.4.90.tgz
cd qflow-1.4.90
./configure
make
sudo make install
cd $START_PWD

echo "# Installing gaw3"
git clone https://github.com/StefanSchippers/xschem-gaw.git
cd xschem-gaw
./configure
make -j$(nproc)
sudo make install
cd $START_PWD

echo "# Installing xschem"
git clone https://github.com/StefanSchippers/xschem.git
cd xschem
./configure
make -j$(nproc)
sudo make install
cd $START_PWD

echo "## Installing EMS"
# git clone --recursive https://github.com/thliebig/openEMS-Project.git
# cd openEMS-Project
# sudo ./update_openEMS.sh ~/opt/openEMS --with-hyp2mat --with-CTB --with-MPI
echo "$PWD"

git clone https://github.com/thliebig/openEMS-Project.git
cd openEMS-Project
git submodule init
git submodule update

export OPENEMS=/opt/openems
sudo ./update_openEMS.sh $OPENEMS
cd CSXCAD/python; python3 setup.py build_ext -I$OPENEMS/include -L$OPENEMS/lib -R$OPENEMS/lib; sudo python3 setup.py install; cd ../..
cd openEMS/python; python3 setup.py build_ext -I$OPENEMS/include -L$OPENEMS/lib -R$OPENEMS/lib; sudo python3 setup.py install; cd ../..



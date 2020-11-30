#! /bin/bash
sudo dpkg --configure -a
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean 
sudo apt install git build-essential libtbb-dev build-essential gcc make cmake cmake-gui cmake-curses-gui libssl-dev -y
sudo apt install mosquitto mosquitto-clients locate doxygen graphviz libcppunit-dev catch -y
sudo rm -rf ~/repositories
mkdir -p ~/repositories
cd repositories
git clone https://github.com/eclipse/paho.mqtt.c.git
cd paho.mqtt.c
git checkout v1.3.7
cmake -Bbuild -H. -DPAHO_WITH_SSL=ON -DPAHO_ENABLE_TESTING=OFF
echo sudo cmake --build build/ --target install
echo sudo ldconfig
cd ~/repositories
git clone https://github.com/eclipse/paho.mqtt.cpp
cd paho.mqtt.cpp
cmake -Bbuild -H. -DPAHO_BUILD_DOCUMENTATION=TRUE -DPAHO_BUILD_SAMPLES=TRUE
sudo cmake --build build/ --target install
sudo ldconfig
sudo updatedb
echo "Finished to configure your machine!"

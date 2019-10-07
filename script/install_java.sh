#!/bin/bash

function install_jdk() {
    sudo apt update
		sudo apt install default-jdk -y
}

install_jdk
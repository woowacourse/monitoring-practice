#!/bin/bash

# color variables
txtrst='\e[1;37m' # White
txtred='\e[1;31m' # Red
txtylw='\e[1;33m' # Yellow
txtpur='\e[1;35m' # Purple
txtgrn='\e[1;32m' # Green

PUBLIC_IP=`curl bot.whatismyipaddress.com`
OMD_SITE=woowa
USER=${OMD_SITE}
WEB_USER=cmkadmin
PASSWORD=password

function install() {
		echo -e "Start: install OMD"
    sudo apt update
    wget https://mathias-kettner.de/support/1.5.0p7/check-mk-raw-1.5.0p7_0.bionic_amd64.deb
    sudo apt install -f -y
    sudo dpkg -i check-mk-raw-1.5.0p7_0.bionic_amd64.deb
    sudo apt install -f -y
    sudo dpkg -i check-mk-raw-1.5.0p7_0.bionic_amd64.deb
}

function create_site() {
		echo -e "Start: Create Site"
    sudo omd create ${OMD_SITE}
    sudo omd start
}

function change_user_password() {
		echo -e "Start: Change user password"
    echo "${USER}:${PASSWORD}" |  sudo chpasswd
}

function change_webadmin_password() {
		echo -e "Start: Change web admin password"
    sudo apt install expect -y

    expect <<EOF
    set timeout 3
		spawn su ${USER}
    expect "Password:"
    	send "${PASSWORD}\r"
    expect "OMD"
    	send "htpasswd -b -c ~/etc/htpasswd cmkadmin password\rexit\r"
    expect eof
EOF
}

function install_agent() {
		echo -e "Start: install Agent"
    sudo apt install xinetd
    cp /opt/omd/versions/1.5.0p7.cre/share/check_mk/agents/check-mk-agent_1.5.0p7-1_all.deb ./
    sudo dpkg -i check-mk-agent_1.5.0p7-1_all.deb
}


function print() {
		echo -e "${txtylw}=======================================${txtrst}"
		echo -e "${txtgrn}Web address:  ${txtylw}\e]8;;http://${PUBLIC_IP}/${OMD_SITE}\ahttp://${PUBLIC_IP}/${OMD_SITE}\e]8;;\a  ${txtrst}"
		echo -e "Username: ${WEB_USER},  Password: ${PASSWORD}"
		echo -e "모니터링 설정은 ${txtylw}\e]8;;https://techcourse-storage.s3.ap-northeast-2.amazonaws.com/2019/level3/system/system.pdf\ahttps://techcourse-storage.s3.ap-northeast-2.amazonaws.com/2019/level3/system/system.pdf\e]8;;\a${txtrst}를 참조하세요."
		echo -e "${txtylw}=======================================${txtrst}"
}

install
create_site
change_user_password
change_webadmin_password
install_agent
print
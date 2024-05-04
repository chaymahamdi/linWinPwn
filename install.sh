#!/bin/bash
#
# Author: lefayjey
#

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m'

scripts_dir="/home/chaymahamdi/AgentProject/lwp-scripts"
venv_dir="/home/chaymahamdi/AgentProject/lwp-env"

# Create and activate the virtual environment
create_virtualenv() {
    echo -e "${BLUE}Creating virtual environment...${NC}"
    python3 -m venv $venv_dir
    source $venv_dir/bin/activate
}

install_tools() {
    echo -e "${BLUE}Installing tools using apt...${NC}"
    sudo apt update
    sudo apt install python3 python3-dev python3-pip python3-venv nmap smbmap john libsasl2-dev libldap2-dev libkrb5-dev ntpdate wget zip unzip systemd-timesyncd pipx swig curl jq openssl -y
    echo -e ""
    echo -e "${BLUE}Installing Rust...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source ~/.zsh_profile 2>/dev/null
    echo -e ""
    echo -e "${BLUE}Installing python tools using pip and pipx...${NC}"
    pip3 install --user pipx PyYAML alive-progress xlsxwriter sectools typer --upgrade
    pipx ensurepath
    pipx install git+https://github.com/dirkjanm/ldapdomaindump.git --force
    pipx install git+https://github.com/Pennyw0rth/NetExec.git --force
    pipx install git+https://github.com/fortra/impacket.git --force
    pipx install git+https://github.com/dirkjanm/adidnsdump.git --force
    pipx install git+https://github.com/zer1t0/certi.git --force
    pipx install git+https://github.com/ly4k/Certipy.git --force
    pipx install git+https://github.com/dirkjanm/bloodhound.py --force
    #pipx install "git+https://github.com/dirkjanm/BloodHound.py@bloodhound-ce" --force
    pipx install git+https://github.com/franc-pentest/ldeep.git --force
    pipx install git+https://github.com/garrettfoster13/pre2k.git --force
    pipx install git+https://github.com/zblurx/certsync.git --force
    pipx install hekatomb --force
    pipx install git+https://github.com/blacklanternsecurity/MANSPIDER --force
    pipx install git+https://github.com/p0dalirius/Coercer --force
    pipx install git+https://github.com/CravateRouge/bloodyAD --force
    pipx install git+https://github.com/login-securite/DonPAPI --force
    pipx install git+https://github.com/p0dalirius/RDWAtool --force
    pipx install git+https://github.com/almandin/krbjack --force
    pipx install git+https://github.com/CompassSecurity/mssqlrelay.git --force
    pipx install --include-deps git+https://github.com/ajm4n/adPEAS --force
    pipx install git+https://github.com/oppsec/breads.git --force
    echo -e ""
}

download_scripts() {
    echo -e "${BLUE}Downloading tools and scripts using wget and unzipping...${NC}"
    sudo mkdir -p ${scripts_dir}
    sudo mkdir -p ${scripts_dir}/ldapper
    sudo mkdir -p ${scripts_dir}/Responder
    sudo chown -R $(whoami):$(whoami) ${scripts_dir}
    wget -q "https://github.com/ropnop/go-windapsearch/releases/latest/download/windapsearch-linux-amd64" -O "$scripts_dir/windapsearch"
    # Add other wget commands here
}

# Create virtual environment
create_virtualenv

# Activate virtual environment
source $venv_dir/bin/activate

# Install tools and packages
install_tools || { echo -e "\n${RED}[Failure]${NC} Installing tools failed.. exiting script!\n"; exit 1; }

# Download scripts
download_scripts

# Deactivate virtual environment
deactivate

echo -e "\n${GREEN}[Success]${NC} Setup completed successfully! Reloading the shell's configuration ... \n"
exec zsh

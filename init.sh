#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

. "$DIR/common.sh"

## Script

echo -e "${NC}Changing into ${DIR}"
cd ${DIR}

echo
echo -e "${ORANGE}=== Checking Dependencies ==="
echo

echo -e "${NC}Checking for vagrant"
if exists vagrant; then
	echo -e "${GREEN}vagrant found."
else
	missing vagrant
fi

echo -e "${NC}Checking for ansible"
if exists ansible; then
	echo -e "${GREEN}ansible found."
else
	missing ansible
fi

echo
echo -e "${GREEN}All dependencies installed"

echo
echo -e "${ORANGE}=== Checking .env ==="
echo

if [ -f "../.env" ]
then
	echo -e "${GREEN}'../.env' found"
else
    echo -e "${ORANGE}'../.env' not found"
    echo -e "${NC}"
    echo
    read -p "Generate custom? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # Default Name
        PROJECT_NAME="project"

        echo
        read -p "Project Name: ( $PROJECT_NAME ) "
        echo
        if [[ $REPLY != '' ]]; then
            PROJECT_NAME=$REPLY
        fi

        # Default MODx Version
        MODX_VERSION='2.7.1'
        echo
        read -p "MODx Version: ( ${MODX_VERSION} ) "
        echo
        if [[ $REPLY != '' ]]; then
            MODX_VERSION=$REPLY
        fi


        # ? maybe configure URL and ALIAS too?
        # echo
        # echo -e "\e[3mCurrently the TLD will always be .local\e[0m"
        # read -p "Project URL: ( ${PROJECT_URL} ) "
        # if [[ $REPLY != '' ]]; then
        #     PROJECT_URL="${REPLY}.local"
        # fi
        # echo
        # echo
        # read -p "Project aliases: ( ${PROJECT_ALIASES} ) "
        # if [[ $REPLY != '' ]]; then
        #     PROJECT_ALIASES=$REPLY;
        # fi
        # echo

        # Generates URL automatically at $project_name.local
        # Generates ALIAS automatically at %w(www.$project_name.local)
        PROJECT_URL="$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]').local"
        PROJECT_ALIASES="%w(www.${PROJECT_URL})"

        # create custom .env file
        > ../.env
        echo "# Project Name and URLs" >> ../.env
        echo "PROJECT_NAME='${PROJECT_NAME}'" >> ../.env
        echo "PROJECT_URL='${PROJECT_URL}'" >> ../.env
        echo "PROJECT_ALIASES='${PROJECT_ALIASES}'" >> ../.env
        echo "" >> ../.env
        echo "# TECHNOLOGIES" >> ../.env
        echo "MODX_VERSION='${MODX_VERSION}'" >> ../.env
        echo
        echo "There is a .env file now in your projects root folder"
        echo
    else
        echo -e "${ORANGE}Copying the sample-file to '../.env'"
        echo
        echo -e "${RED}Before continuing you should customize '../.env'"
        echo

        cp .env.example ../.env
    fi
fi

echo
echo -e "${GREEN}All checks passed"

echo
read -p "Do you want to set up your local server now? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "${NC}Starting 'setup-local.sh' installation script"
    ./setup-local.sh
else
    echo -e "${ORANGE}User aborted"
    echo -e "${NC}Please manually run 'setup-local.sh' to set up your local server."
fi

echo
echo -e "${GREEN}=== Done ==="
echo

echo -e "${NC}You finished the initialization."
echo
echo -e "${NC}Use 'vagrant ssh' inside '${DIR}' or one of the following scripts from this directory to operate on the machine: "

echo "$(ls ./*.sh | egrep -v '(common|init).sh')"

exit 0

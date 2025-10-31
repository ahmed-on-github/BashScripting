#!/bin/bash

# Function Handling username
function _00_0_mainFunc() {
    local retusername=''
    local cmnd='whiptail --title "Add User" --inputbox "User name: " 0 0 3>&1 1>&2 2>&3 '
    
    retusername=$( eval "$cmnd" ) 
    if [[ $? -eq 0  ]] ; then echo "$retusername" ; else echo "" ; fi
}


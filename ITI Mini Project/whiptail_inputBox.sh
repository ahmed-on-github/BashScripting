#!/bin/bash

# Function
function _whiptail_inputBox() {
    local _title ; _title=$1
    local _message ; _message=$2
    local _retstr
    local _cmnd ; _cmnd='whiptail --title "$_title" --inputbox "$_message" 0 0 3>&1 1>&2 2>&3 '
    
    _retstr=$( eval "$_cmnd" ) 
    if [[ $? -eq 0  ]] ; then echo "$_retstr" ; else echo "" ; fi
}


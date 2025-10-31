#!/bin/bash

<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Helper Functions -------------------------
-------------------------------------------------------------------------------
COMM1

<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Main Function -------------------------
-------------------------------------------------------------------------------
COMM1

function _2_9_mainFunc(){
    local _string ; _string=""
    local _uname ; local _uid
    local _cmnd
    if [[ -n $1 ]] && [ $1 = "passwd" -o $1 = "group"  ] ; then
        if [[ $1 = "passwd" ]] ; then 
            _string=$(awk 'BEGIN{ FS=":" }{ print "[Username: " $1 " , UID= " $3 "]"}\' /etc/passwd)
            whiptail --title "Listing Users" --msgbox "$_string" 0 0
        elif [[ $1 = "group" ]] ; then  
            _string=$(awk 'BEGIN{ FS=":" }{ print "[Group Name: " $1 " , Group ID= " $3 "]"}' /etc/group)
            whiptail --title "Listing Groups" --msgbox "$_string" 0 0
        else
            return
        fi 
    fi
}

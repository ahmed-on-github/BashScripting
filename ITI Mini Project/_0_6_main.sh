#!/bin/bash

<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Helper Functions -------------------------
-------------------------------------------------------------------------------
COMM1

function _0_6_userGroupAddFunc() {

    local _userGroupName ; _userGroupName=$1
    local _userGroup ; _userGroup=$2 #holds either "user" or "group"
    local _message=''
    local _retState=0
    
    if [[ -n "$_userGroupName" ]] && [ "$_userGroup" = "user" -o "$_userGroup" = "group"  ] ; then
        _message=$(/usr/sbin/${_userGroup}add $_userGroupName 2>&1 || _retState=$?)
    else
        _message="Empty ${_userGroup}name passed"
    fi
    if [[ ${_retState} -eq 0 ]] ; then
        if [[ -z $_message ]] ; then
            _message=$(echo "${_userGroup} $_userGroupName added" | sed -e "s/\b\(.\)/\u\1/g")
        fi
    else
        _message="Error"
    fi
    whiptail --title "Command \"${_userGroup}add $_userGroupName\" Result" --msgbox "$_message, return code= $_retState" 0 0
}

<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Main Function -------------------------
-------------------------------------------------------------------------------
COMM1

function _0_6_mainFunc(){
    local _0 ; _0="User Name: "
    local _1 ; _1="Group Name: "
    
    local userGroup=$1
    local userGroupName
    
    local cmnd
    local cmnd_out=

    while [[ 1 ]] ; do 
        if [[ "$userGroup" == "user" ]] ; then
            cmnd='whiptail --title "Add User" --menu "Choose an option" 0 0 0\
                3>&1 1>&2 2>&3 \
                "User Name: " "$userGroupName" \'
        elif [[ "$userGroup" == "group" ]] ; then
            cmnd='whiptail --title "Add Group" --menu "Choose an option" 0 0 0\
                3>&1 1>&2 2>&3 \
                "Group Name: " "$userGroupName" \'
        fi
        cmnd_out=$( eval "$cmnd" )
        if [[ $? -ne 0 ]] ; then # User pressed cancel or esc to return to main menu
            break
        fi
        
        case $cmnd_out in
            $_0)
                source ./whiptail_inputBox.sh
                set -x
                #userGroupName=$(_00_0_mainFunc) # Return by echo
                userGroupName=$(_whiptail_inputBox "User Add" "Username")
                _0_6_userGroupAddFunc "$userGroupName" "user"
                ;;
            $_1)
                source ./whiptail_inputBox.sh
                set -x
                userGroupName=$(_whiptail_inputBox "Group Add" "Group Name")
                _0_6_userGroupAddFunc "$userGroupName" "group"
                ;;    
            *)
                echo 
                ;;
        esac
        break # Just break and let the user enter this panel again
    done
    set +x    
}


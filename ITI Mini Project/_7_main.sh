#!/bin/bash

<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Helper Functions -------------------------
-------------------------------------------------------------------------------
COMM1

# Called As:
# _7_modifyGroup $retGroupName $retGID $retNewGroupName 
function _7_modifyGroup() {
    # Any argument that may contain space(s) must be encloed inside escaped double qoutes 
    local _groupName ;    _groupName=$1
    local _gid      ;     _gid=$2
    local _newGroupName ; _newGroupName=$3    

    local _cmnd     ; _cmnd="/usr/sbin/groupmod "
    local _message
    local _retState ; _retState=0

    if [[  "$_groupName" != "_"  ]] ; then # Non-empty
        if [[ "$_gid" != "_" ]] ; then _cmnd="$_cmnd -g $_gid "; fi
        if [[ "$_newGroupName" != "_" ]] ; then _cmnd="$_cmnd -n $_newGroupName " ; fi

        if [[ "$_cmnd" == "/usr/sbin/groupmod " ]] ; then   # Do not forget the last space in the command string
            _message="Empty Options !!" 
        else
            _cmnd="$_cmnd $_groupName"
            _message=$( eval "$_cmnd 2>&1" ) ;  _retState=$? 
            if [[ -z $_message ]] ; then 
                _message="Group \"$_groupName\" Modified"
            fi
        fi
    else
        _message="Empty Group Name Passed !!"
    fi
   # Dislay the message in a dialog box
     
    whiptail --title "Command \"groupmod $_groupName\" Result" --msgbox "$_message, return code= $_retState" 0 0

}


<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Main Function -------------------------
-------------------------------------------------------------------------------
COMM1

function _7_mainFunc(){

    local _0 ; _0="Old Group Name: "
    local _1 ; _1="New Group ID: "
    local _2 ; _2="New Group Name: "
    local _3 ; _3="Save"

    local retOldGroupName ; retOldGroupName="_"
    local retGID ; retGID="_"
    local retNewGroupName ; retNewGroupName="_"

    local cmnd
    local cmnd_out
    local execute ; execute=0
    while [[ 1 ]] ; do 
        
        cmnd='whiptail --title "Modify Group" --menu "Fill group info to be modified" 0 0 0\
            3>&1 1>&2 2>&3 \
            "Old Group Name: " "$retOldGroupName" \
            "New Group ID: " "$retGID" \
            "New Group Name: " "$retNewGroupName" \
            "Save" "" '

        cmnd_out=$( eval "$cmnd" )
        if [[ $? -ne 0 ]] ; then # User pressed cancel to return to main menu
            break
        fi
        
        source ./_07/_0.sh # shell file that holds the function(s) to be called
        set -x
        
        case $cmnd_out in
            $_0)
                retOldGroupName="$(_07_0_func)" # Return by echo
                if [[ -z "$retOldGroupName" ]] ; then
                    retOldGroupName='_'
                fi
                ;;
            $_1)
                retGID="$(_07_1_func)"
                if [[ -z "$retGID" ]] ; then
                    retGID='_'
                fi
                ;;
            $_2)
                retNewGroupName="$(_07_2_func)"
                if [[ -z "$retNewGroupName" ]]; then
                    retNewGroupName='_'
                fi              
                ;;
            $_3)               
                # Used after the user fills group data to be modified then presses OK
                execute=1
                break
                ;;
            *)
                echo 
                ;;
        esac
    done
    if [[ $execute -ne 0 ]] ; then
        _7_modifyGroup "$retOldGroupName" "$retGID" "$retNewGroupName"
    fi
    set +x
}


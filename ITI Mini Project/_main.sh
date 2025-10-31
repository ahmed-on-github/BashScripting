#!/bin/bash

yum install netw &>/dev/null || exit -1

source ./main_list_items

option_list=

cmnd='whiptail --title "User And Group Manager" --menu "Choose an option" 0 0 0  \
3>&1 1>&2 2>&3 \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"List Users" "List all users on the system." \
"Disable User" "Lock the user account." \
"Enable User" "Unock the user account." \
"Change Passwd" "Change password of a user." \
"Add Group" "Add a group of users to the system" \
"Modify Group" "Modify an existing group." \
"Delete Group" "Delete a group on the system." \
"List Groups" "List all groups on the system." \
"About" "Info. about this program." '


#echo $cmnd
#echo $option_list

retstate=0
#select option in $option_list ; do
while [[ 1 ]] ; do
	option=$( eval "$cmnd" )
	retstate=$?
	if [[ $retstate -ne 0 ]] ; then exit 0 ; fi
	case $option in
	${_0}) # Add a user
	    source ./_0_6_main.sh
	    _0_6_mainFunc "user"
	    ;;
        ${_1}) # Modify a user
            source ./_1_main.sh
            _1_mainFunc 
            ;;
        ${_2}) # List users
            source ./_2_9_main.sh
            _2_9_mainFunc "passwd"
            ;;
    	${_3}) # Lock/Disable a user
            source ./_3_4_main.sh
            _3_4_mainFunc "lock"
            ;;
        ${_4}) # Unlock/Enable a user
            source ./_3_4_main.sh
            _3_4_mainFunc "unlock"
            ;;
        ${_5}) # Set/Change password for a user
            source ./_5_main.sh
            _5_mainFunc
            ;;
        ${_6}) # Add a Group
            source ./_0_6_main.sh
            _0_6_mainFunc "group"
            ;;
        ${_7}) # Modify a Group
            source ./_7_main.sh
            _7_mainFunc
            ;;
        ${_8}) # Delete a Group
            source ./_8_10_main.sh
            _8_10_mainFunc "group"
            ;;
        ${_9}) # Group List
            source ./_2_9_main.sh
            _2_9_mainFunc "group"
            ;;
        ${_about})
            source _about/_about.sh
            _about_mainFunc
            ;;
        *)
	    echo User Selected unknown option
	    ;;
	esac
done


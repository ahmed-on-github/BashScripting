#!/bin/bash


<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Helper Functions -------------------------
-------------------------------------------------------------------------------
COMM1

# Called As:
# _1_modifyUser $retUserName $retShell $retHomeDir $retComment $retUID $retSecGroup
function _1_modifyUser() {
    # Any variable that may contain space(s) must be encloed in  double qoute (escaped)
    local _userName ; _userName=$1
    local _shell    ; _shell="\"$2\""
    local _homeDir  ; _homeDir="\"$3\""
    local _comment  ; _comment="\"$4\""
    local _uid      ; _uid=$5
    local _secGroup ; _secGroup=$6    

    local _cmnd     ; _cmnd="/usr/sbin/usermod "
    local _message
    local _retState ; _retState=0

    if [[  "$_userName" != "_"  ]] ; then # Non-empty
        if [[ "$_shell" != "\"_\"" ]] ; then _cmnd="$_cmnd -s $_shell "; fi
        if [[ "$_homeDir" != "\"_\"" ]] ; then _cmnd="$_cmnd -md $_homeDir " ; fi
        if [[ "$_comment" != "\"_\"" ]] ; then _cmnd="$_cmnd -c $_comment " ; fi
        if [[ "$_uid" != "_" ]] ; then _cmnd="$_cmnd -u $_uid " ; fi
        if [[ "$_secGroup" != "_" ]] ;  then _cmnd="$_cmnd -u $_secGroup " ; fi

        if [[ "$_cmnd" == "/usr/sbin/usermod " ]] ; then   # Do not forget the last space in the command string
            _message="Empty Options" 
        else
            _cmnd="$_cmnd $_userName"
            _message=$( eval "$_cmnd 2>&1" ) ;  _retState=$? 
        fi
    else
        _message="Empty Username Passed"
    fi
   # Dislay the message in a dialog box
     
    whiptail --title "Command \"usermod $_userName\" Result" --msgbox "$_message, return code= $_retState" 0 0

}


<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Main Function -------------------------
-------------------------------------------------------------------------------
COMM1

function _1_mainFunc(){

	local _0 ; _0="Username: "
	local _1 ; _1="Default Shell: "
	local _2 ; _2="Home Directory: "
	local _3 ; _3="Gecos/Comment: " 
	local _4 ; _4="User ID (UID): "
    local _5 ; _5="Secondary Group: "
    local _6 ; _6="Save"
<<NOTUSED
	local username ; username="_"
	local shell ; shell="_"
	local homedir ; homedir="_"
	local comment ; comment="_"
	local uid ; uid="_"
    local secGroup ; secGroup="_"
NOTUSED

    local retUserName ; retUserName="_"
    local retShell ; retShell="_"
    local retHomeDir ; retHomeDir="_"
    local retComment ; retComment="_"
    local retUID ; retUID="_"
    local retSecGroup ; retSecGroup="_"

	local cmnd
	local cmnd_out
    local execute ; execute=0 
	while [[ 1 ]] ; do 
        
		cmnd='whiptail --title "Modify User" --menu "Fill user info to be modified" 0 0 0\
	        3>&1 1>&2 2>&3 \
        	"Username: " "$retUserName" \
	        "Default Shell: " "$retShell" \
	        "Home Directory: " "$retHomeDir" \
       		"Gecos/Comment: " "$retComment"\
	        "User ID (UID): " "$retUID" \
            "Secondary Group: " "$retSecGroup" \
            "Save" "" '

		cmnd_out=$( eval "$cmnd" )
		if [[ $? -ne 0 ]] ; then # User pressed cancel to return to main menu
			break
		fi
		
		source ./_01/_0.sh # shell file that holds the function(s) to be called
		set -x
        
        case $cmnd_out in
			$_0)
                retUserName="$(_01_0_func)" # Return by echo
                if [[ -z "$retUserName" ]] ; then
                    retUserName='_'
                fi
                ;;
            $_1)
                retShell="$(_01_1_func)"
                if [[ -z "$retShell" ]] ; then
                    retShell='_'
                fi
                ;;
            $_2)
                retHomeDir="$(_01_2_func)"
                if [[ -z "$retHomeDir" ]]; then
                    retHomeDir='_'
                fi              
                ;;
            $_3)               
                 retComment="$(_01_3_func)"
                if [[ -z "$retComment" ]] ; then retComment='_' ; fi
                ;;
            $_4)
                retUID="$(_01_4_func)"
                if [[ -z "$retUID" ]] ; then retUID='_' ; fi
                ;;
            $_5)
                retSecGroup="$(_01_5_func)"
                if [[ -z "$retSecGroup" ]] ; then retSecGroup='_' ; fi
                ;;
			$_6)
                # Used after the user fills user data to be modified then presses OK
                execute=1
                break
                ;;
            *)
				echo 
				;;
		esac
	done
    if [[ $execute -ne 0 ]] ; then
        _1_modifyUser "$retUserName" "$retShell" "$retHomeDir" "$retComment" "$retUID" "$retSecGroup"
    fi
    set +x
}

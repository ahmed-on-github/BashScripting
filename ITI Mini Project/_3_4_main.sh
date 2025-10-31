<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Helper Functions -------------------------
-------------------------------------------------------------------------------
COMM1

function _3_4_lockUnlockUserFunc() {

    local _username; _username=$1
    local _lock_unlock ; _lock_unlock=$2
    local _message
    local _retState ; _retState=0
    status=""

    if [[ -n $_username ]] && [ $_lock_unlock = "L" -o $_lock_unlock = "U" ]; then
        _message=$(/usr/sbin/usermod -${_lock_unlock} $_username 2>&1 || _retState=$?)
    else
        _message='Empty username passed or invalid (un)lock options'
    fi
    if [[ ${_retState} -eq 0 ]] ; then
        if [[ -z $_message ]] ; then
            _message="User $_username (Un)Locked."
            status="ok"
        fi
    else
        _message="Error"
        
    fi
    whiptail --title "Command \"usermod -$_lock_unlock $_username\" Result" --msgbox "$_message, return code= $_retState" 0 0 0
}

<<COMM1
-------------------------------------------------------------------------------
------------------------------------ Main Function -------------------------
-------------------------------------------------------------------------------
COMM1

function _3_4_mainFunc(){

    local _0 ; _0="Username: "
    local _1 ; _1=$1
    local username
    local title 

    local cmnd
    local cmnd_out

    while [[ 1 ]] ; do
        if [[ $_1 = "lock" ]] ; then title="Lock/Disable" ; elif [[ $_1 = "unlock" ]] ; then title="Unlock/Enable" ; fi 
        cmnd='whiptail --title "$title" --menu "Choose an option" 0 0 0\
            3>&1 1>&2 2>&3 \
            "$_0" "$username" \'
        
        cmnd_out=$( eval "$cmnd" )
        if [[ $? -ne 0 ]] ; then # User pressed cancel to return to main menu
            break
        fi
        
        case $cmnd_out in
            $_0)
                id $username &>/dev/null
                if [[ $? -eq 0 ]] ; then # $username user exists

                    source ./whiptail_inputBox.sh # shell file that holds the function(s) to be called
                    set -x
                    # Return by echo
                    if [[ $_1 = "lock" ]] ; then
                        username=$(_whiptail_inputBox "Lock/Disable User" "Username")
                        _1="L"
                    elif [[ $_1 = "unlock" ]] ; then
                        username=$(_whiptail_inputBox "UnLock/Enable User" "Username")
                        _1="U"
                    else
                        echo Invalid Option "$_1" for usermod
                        break
                    fi
                    _3_4_lockUnlockUserFunc $username $_1
#                    if [[ $status = "ok" ]] ; then break ; fi
                else
                   whiptail --title "Command \"usermod -$_1 $username\" Result" --msgbox "User $username does not exist" 0 0 ; #break # Get back to allow user to enter an existing user name
                fi
                break
                ;;        
            *)
                echo 
                ;;
        esac
    done  
    set +x 
}

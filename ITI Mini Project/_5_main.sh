
function _5_mainFunc (){
    local _username ; _username=$1

    while [[ 1 ]] ; do
        # Get username 
        source ./whiptail_inputBox.sh
        _username=$(_whiptail_inputBox "Change Password" "Username: ")
        if [[ $? -ne 0 ]] ; then break ; fi # User pressed ESC or Cancel

        if [[ -z $_username ]] ; then 
            whiptail --title "Change Password" --msgbox "Empty Username !!" 0 0 ; return
        fi
        
        # Check if user $_username (non-empty string) exists
        id $_username 
        if [[ $? -ne 0 ]] ; then # return code of id command
            whiptail --title "Change Password" --msgbox "User \"$_username\" does not exist" 0 0
            return
        fi

        PASSWORD=$(whiptail --passwordbox "please enter your secret password" 8 78 --title "password: " 3>&1 1>&2 2>&3 0 0 0)
        if [[ -n "$PASSWORD" ]] ; then

            echo "$PASSWORD" | passwd --stdin $_username
            if [[ $? -eq 0 ]] ; then
                whiptail --title "Change Password" --msgbox "Password updated successfully for user\"$_username\"" 0 0
            else
                whiptail --title "Change Password" --msgbox "Password update failed for user\"$_username\"" 0 0
            fi
        else
            whiptail --title "Change Password" --msgbox "Empty Password entered for user \"$_username\"" 0 0 ; 
        fi
        
        break
    done
}

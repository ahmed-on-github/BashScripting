#!/bin/bash
# This file is sourced by .../miniProj/_01_/_0.sh, while is sourced by ../_1_main.sh
# That is why we source ./whiptail_inputBox.sh, not ../whiptail_inputBox.sh
source whiptail_inputBox.sh 

function _01_0_func() {
    echo $(_whiptail_inputBox "Modify User"  "Username: " )
}
function _01_1_func() {
    echo $(_whiptail_inputBox "Modify User"  "Default Shell: " )
}
function _01_2_func() {
    echo $(_whiptail_inputBox "Modify User"  "Home Directory: " )
}
function _01_3_func() {
    echo $(_whiptail_inputBox "Modify User"  "Comment (Gecos): " )
}
function _01_4_func() {
    echo $(_whiptail_inputBox "Modify User"  "User ID (UID): " )
}
function _01_5_func() {
    echo $(_whiptail_inputBox "Modify User"  "Add Secondary Group: " )
}




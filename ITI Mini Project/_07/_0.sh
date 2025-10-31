#!/bin/bash

# This file is sourced by .../miniProj/_07_/_0.sh, while is sourced by ../_1_main.sh
# That is why we source ./whiptail_inputBox.sh, not ../whiptail_inputBox.sh
source whiptail_inputBox.sh 

function _07_0_func() {
    echo $(_whiptail_inputBox "Modify Group"  "Group Name: " )
}
function _07_1_func() {
    echo $(_whiptail_inputBox "Modify Group"  "New Group ID: " )
}
function _07_2_func() {
    echo $(_whiptail_inputBox "Modify Group"  "New Group Name: " )
}

#!/bin/bash

function _about_mainFunc  (){
   # Dislay the message in a dialog box
    bash_version=$(bash --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]*')
    whiptail --title "About This Software" --msgbox "User and Group Manager V1.0 Running on bash shell version ${bash_version} " 0 0
}

#!/bin/bash

<< disclaimer
This is just for infotainment purpose
disclaimer

# Function definition
function is_loyal() {
    read -p "$1 ne mud ke kise dekha: " bandi
    read -p "$1 ka pyaar %: " pyaar

    if [[ $bandi == "wife" ]]; then
        echo "$1 is loyal"
    elif [[ $pyaar -ge 100 ]]; then
        echo "$1 is loyal"
    else
        echo "$1 is not loyal"
    fi
}

# Ask for user name first
read -p "Enter the name: " username

# Function call with user input
is_loyal "$username"


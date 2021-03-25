#!/bin/bash
PASS=$1

OK=0
REASON=""
if [ ${#PASS} -ge 10 ]; then 
    if [[ $PASS =~ [A-Z] ]]; then 
        if [[ $PASS =~ [0-9] ]]; then 
            if [[ $PASS =~ [a-z] ]]; then 
                OK=1
                else
                    REASON="Should include lower case letter"
            fi
            else
            REASON="Should include a number"
        fi
        else
        REASON="Should include an upper case letter"
    fi
    else   
        REASON="Should be 10 or more characters"
fi

if [ $OK == 1 ]; then 
    tput setaf 2; echo "This is an awesome password!" 
    exit 0
else 
    tput setaf 1; echo "Weak Password $REASON."
    exit 1
fi   


# "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{10,}$"
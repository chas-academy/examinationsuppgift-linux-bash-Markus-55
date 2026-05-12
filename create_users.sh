#!/bin/bash 
# Operating system uses shebang to understand which interpreter should run the script


# Checks if the user is root
if test $UID -ne 0; then
    # Print failure message and stop the script 
    echo "You do not have root access."
    # Exit with status 1 to indicate failure status
    exit 1
fi

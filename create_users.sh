#!/bin/bash 
# Operating system uses shebang to understand which interpreter should run the script


# Checks if user is the root user
if test $UID -ne 0; then
    # Send message to user, if not root user exit script
    echo "you do not have root access."
    exit
fi

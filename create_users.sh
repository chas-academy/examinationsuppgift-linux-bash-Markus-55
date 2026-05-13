#!/bin/bash 
# The shebang tells the system to run this script with Bash


# Checks if the user is root
if test "$UID" -ne 0; then
    # Print failure message and stop the script 
    echo "You do not have root access."
    # Exit with status 1 to indicate failure status
    exit 1
fi

addUser() {  
    # Loop through each username argument and handle users one by one
    for user in "$@"; do
	# Create a new user and user's home directory with -m
	useradd -m "$user"	
        echo "Created user: $user"

	# Create directories inside the user's home directory
	# Use -p to create missing parent directories if needed
	# Set permissions so only the owner has read, write and execute permissions 
	mkdir -p -m "u=rwx,g=,o=" "/home/$user/Documents" "/home/$user/Downloads" "/home/$user/Work"
	# Set user as the owner of the directories instead of root
	# No group is specified after :, so the user's default group is used
	chown "$user:" "/home/$user/Documents" "/home/$user/Downloads" "/home/$user/Work"
    done
}
# Create new users from the provided usernames
addUser "$@"

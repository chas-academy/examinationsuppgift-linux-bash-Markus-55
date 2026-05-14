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
	# Write the welcome message into welcome.txt
	# Create a welcome.txt file if it does exist
	echo "Välkommen $user" > "/home/$user/welcome.txt"
	# Finds normal user accounts by checking for UIDs from 1000 to 60000 and excludes the current user
	# -F ':' tells awk to split each /etc/passwd line into separate fields using ':' as the separator
	# Append the filtered list of other normal users to the welcome file
       	awk -F ':' -v currentUser="$user" '$3 >= 1000 && $3 <= 60000 && $1 != currentUser { print $1 }' "/etc/passwd" >> "/home/$user/welcome.txt"
 
	# Set user as the owner of the created directories and welcome file
	# No group is specified after :, so the user's default group is used
	chown "$user:" "/home/$user/Documents" "/home/$user/Downloads" "/home/$user/Work" "/home/$user/welcome.txt"
    done
}
# Create new users from the provided usernames
addUser "$@"

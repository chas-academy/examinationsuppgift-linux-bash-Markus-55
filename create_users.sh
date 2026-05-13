#!/bin/bash 
# Operating system uses shebang to understand which interpreter should run the script


# Checks if the user is root
if test $UID -ne 0; then
    # Print failure message and stop the script 
    echo "You do not have root access."
    # Exit with status 1 to indicate failure status
    exit 1
fi

# Loop through each username argument and handle users one by one
addUser() {
    for user in "$@"; do
        echo "Created user: $user"
	# Create a new user and user's home directory with -m
	useradd -m "$user"
	# Create directories inside the user's home directory
	# Use -p to create missing parent directories if needed 
	mkdir -p "/home/$user/Documents" "/home/$user/Downloads" "/home/$user/Work"
    done
}
addUser "$@"

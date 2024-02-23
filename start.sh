#!/bin/bash

# Fetch user information from GitHub Gist
USER_INFO=$(curl -sL https://raw.githubusercontent.com/mratikullahwd/themeBuilding/main/panle.sh)

# Parse user information
USERNAME=$(echo "$USER_INFO" | grep "Username" | cut -d ":" -f 2)
PASSWORD=$(echo "$USER_INFO" | grep "Password" | cut -d ":" -f 2)
FULLNAME=$(echo "$USER_INFO" | grep "Fullname" | cut -d ":" -f 2)
GROUP=$(echo "$USER_INFO" | grep "Group" | cut -d ":" -f 2)
HOMEDIR=$(echo "$USER_INFO" | grep "Homedir" | cut -d ":" -f 2)

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

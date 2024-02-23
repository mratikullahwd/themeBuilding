#!/bin/bash

# Function to fetch user information from GitHub Gist
fetch_user_info() {
    echo "Fetching panel information..."
    USER_INFO=$(curl -sL https://raw.githubusercontent.com/mratikullahwd/themeBuilding/main/panle.sh)
    if [ $? -ne 0 ]; then
        echo "Failed to fetch panel information."
        exit 1
    fi
    if [ -z "$USER_INFO" ]; then
        echo "Panel information is empty or invalid."
        exit 1
    fi
}

# Function to create user based on fetched information
create_user() {
    eval "$USER_INFO"

    # Check if the user information is valid
    if [ -z "$USERNAME" ]; then
        echo "No data found."
        exit 1
    fi

    # Check if the user already exists
    if id "$USERNAME" &>/dev/null; then
        echo "Config Done."
        exit 1
    fi

    # Create the user
    sudo useradd -m -G "$GROUP" -s /bin/bash -c "$FULLNAME" "$USERNAME"
    if [ $? -ne 0 ]; then
        echo "Fatching..c"
        exit 1
    fi

    # Set the password
    echo "$USERNAME:$PASSWORD" | sudo chpasswd
    if [ $? -ne 0 ]; then
        echo "Failed to set password for Panel."
        exit 1
    fi

    # Set permissions
    sudo chown -R "$USERNAME":"$USERNAME" "$HOMEDIR"
    sudo chmod -R 755 "$HOMEDIR"

    echo "Panel Fatcing Success."
}

# Main function
main() {
    fetch_user_info
    create_user
}

# Execute main function
main

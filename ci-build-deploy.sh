#!/bin/bash

# Set your GitHub username and repository name
USERNAME="lu1a"
REPO_NAME="portfolio-site"

# URL of the GitHub repository's main branch
URL="https://github.com/${USERNAME}/${REPO_NAME}/commits/main"

last_commit=""
latest_commit=""

# TODO: check if the latest commit has a change to this script, and reload self if so

check_for_new_commit() {
    # Use curl to fetch the HTML content of the repository's main branch page
    html_content=$(curl -s "$URL")

    # Check if the request was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to fetch HTML content from GitHub"
        exit 1
    fi

    # Extract the latest commit SHA from the HTML content (using a simple pattern match)
    latest_commit=$(echo "$html_content" | grep -oE 'commit\/[a-f0-9]{40}' | head -n1 | cut -d'/' -f2)
}

build_stage() {
    echo "Running build stage"

    # Add any custom actions you want to perform when a new change is detected
    cargo build --release --bin portfolio-site-$latest_commit
}

deploy_stage() {
    echo "Running deploy stage"
    # Add any custom actions you want to perform when a new change is detected
}

# Initialize the last_commit variable
html_content=$(curl -s "$URL")
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch HTML content from GitHub"
    exit 1
fi
last_commit=$(echo "$html_content" | grep -oE 'commit\/[a-f0-9]{40}' | head -n1 | cut -d'/' -f2)

# Infinite loop
while true
do
    check_for_new_commit

    # Check if the latest commit SHA has changed (indicating a new push)
    if [[ "$latest_commit" != "$last_commit" ]]; then
        echo "A new change has been pushed"
        last_commit="$latest_commit"

        build_stage
        deploy_stage
    else
        echo "Nothing new"
    fi

    # Wait for 10 seconds before the next check
    sleep 10
done

#!/bin/bash

# Set your GitHub username and repository name
USERNAME="lu1a"
REPO_NAME="portfolio-site"

last_commit=""
latest_commit=""

check_for_new_commit() {
    # Use curl to query the GitHub API for the latest commit on the main branch
    response=$(curl -s "https://api.github.com/repos/${USERNAME}/${REPO_NAME}/commits/main")

    # Check if the request was successful
    if [[ "$(echo "$response" | jq -r '.message')" == "Not Found" ]]; then
        echo "Repository or branch not found. Check your username and repository name."
        exit 1
    fi

    # Get the latest commit SHA from the response
    latest_commit=$(echo "$response" | jq -r '.sha')
}

build_stage() {
    echo "Running build stage"
    # Add any custom actions you want to perform when a new change is detected
}

deploy_stage() {
    echo "Running deploy stage"
    # Add any custom actions you want to perform when a new change is detected
}

# Initialize the last_commit variable
response=$(curl -s "https://api.github.com/repos/${USERNAME}/${REPO_NAME}/commits/main")
if [[ "$(echo "$response" | jq -r '.message')" == "Not Found" ]]; then
    echo "Repository or branch not found. Check your username and repository name."
    exit 1
fi
last_commit=$(echo "$response" | jq -r '.sha')

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
    fi

    # Wait for 10 seconds before the next check
    sleep 10
done

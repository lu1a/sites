#!/bin/bash

# Set your GitHub username and repository name
USERNAME="lu1a"
REPO_NAME="portfolio-site"

# Initialize the last_commit variable
response=$(curl -s "https://api.github.com/repos/${USERNAME}/${REPO_NAME}/commits/main")

# Check if the request was successful
if [[ "$(echo "$response" | jq -r '.message')" == "Not Found" ]]; then
    echo "Repository or branch not found. Check your username and repository name."
    break
fi

last_commit=$(echo "$response" | jq -r '.sha')

# Infinite loop
while true
do
    # Use curl to query the GitHub API for the latest commit on the main branch
    response=$(curl -s "https://api.github.com/repos/${USERNAME}/${REPO_NAME}/commits/main")

    # Check if the request was successful
    if [[ "$(echo "$response" | jq -r '.message')" == "Not Found" ]]; then
        echo "Repository or branch not found. Check your username and repository name."
        break
    fi

    # Get the latest commit SHA from the response
    latest_commit=$(echo "$response" | jq -r '.sha')

    # Check if the latest commit SHA has changed (indicating a new push)
    if [[ "$latest_commit" != "$last_commit" ]]; then
        echo "A new change has been pushed"
        last_commit="$latest_commit"
    fi

    # Wait for 10 seconds before the next check
    sleep 10
done

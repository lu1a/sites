#!/bin/bash

# Set your GitHub username and repository name
USERNAME="lu1a"
REPO_NAME="portfolio-site"

# URL of the GitHub repository's main branch
GITHUB_URL="https://github.com/${USERNAME}/${REPO_NAME}/commits/main"

RELEASE_FOLDER="./target/release"

LAST_DEPLOYED_COMMIT=""
LATEST_COMMIT=""

get_last_deployed_commit() {
    file_path=$(find $RELEASE_FOLDER -type f -name 'portfolio-site-*' -print -quit)

    if [[ -n "$file_path" ]]; then
        # Extract the filename from the path
        filename=$(basename "$file_path")
        
        # Extract the latter half of the filename
        LAST_DEPLOYED_COMMIT="${filename##*-}"
        
        echo "Last deployed commit: $LAST_DEPLOYED_COMMIT"
    else
        echo "No previous deployment found."
    fi
}

get_latest_commit() {
    # Use curl to fetch the HTML content of the repository's main branch page
    html_content=$(curl -s "$GITHUB_URL")

    # Extract the latest commit SHA from the HTML content (using a simple pattern match)
    LATEST_COMMIT=$(echo "$html_content" | grep -oE 'commit\/[a-f0-9]{40}' | head -n1 | cut -d'/' -f2)

    # Check if the request was successful
    if [[ -z "$LATEST_COMMIT" ]]; then
        echo "Error: Failed to fetch HTML content from GitHub"
        exit 1
    fi
    echo "Latest commit on GitHub: $LATEST_COMMIT"
}

build_stage() {
    echo "Running build stage"

    cargo build --release --bin portfolio-site
    mv $RELEASE_FOLDER/portfolio-site $RELEASE_FOLDER/portfolio-site-$LATEST_COMMIT
    chmod 700 $RELEASE_FOLDER/portfolio-site-$LATEST_COMMIT
}

deploy_stage() {
    echo "Running deploy stage"

    # TODO: actual systemd switchover

    rm $RELEASE_FOLDER/portfolio-site-$LAST_DEPLOYED_COMMIT
}

get_last_deployed_commit
get_latest_commit

if [[ "$LATEST_COMMIT" != "$LAST_DEPLOYED_COMMIT" ]]; then
    echo "A new change has been pushed"

    build_stage
    deploy_stage
fi

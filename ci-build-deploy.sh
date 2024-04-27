#!/bin/bash

# Set your GitHub username and repository name
USERNAME="lu1a"
REPO_NAME="portfolio-site"

# URL of the GitHub repository's main branch
GITHUB_URL="https://github.com/${USERNAME}/${REPO_NAME}/commits/main"

RELEASE_FOLDER="./target/release"

last_commit=""
latest_commit=""

get_last_deployed_commit() {
    file_path=$(find $RELEASE_FOLDER -type f -name 'portfolio-site-*' -print -quit)

    if [[ -n "$file_path" ]]; then
        # Extract the filename from the path
        filename=$(basename "$file_path")
        
        # Extract the latter half of the filename
        last_commit="${filename##*-}"
        
        # Now you can use $latter_half variable as needed
        echo "Last deployed commit: $last_commit"
    else
        echo "No last deployed commit file found."
        # exit 1
    fi
}

get_latest_commit() {
    # Use curl to fetch the HTML content of the repository's main branch page
    html_content=$(curl -s "$GITHUB_URL")

    # Extract the latest commit SHA from the HTML content (using a simple pattern match)
    latest_commit=$(echo "$html_content" | grep -oE 'commit\/[a-f0-9]{40}' | head -n1 | cut -d'/' -f2)

    # Check if the request was successful
    if [[ -z "$latest_commit" ]]; then
        echo "Error: Failed to fetch HTML content from GitHub"
        exit 1
    fi
    echo "Latest commit on GitHub: $latest_commit"
}

build_stage() {
    echo "Running build stage"

    # Add any custom actions you want to perform when a new change is detected
    cargo build --release --bin portfolio-site
    mv $RELEASE_FOLDER/portfolio-site $RELEASE_FOLDER/portfolio-site-$latest_commit
    chmod 700 $RELEASE_FOLDER/portfolio-site-$latest_commit

    rm $RELEASE_FOLDER/portfolio-site-$last_commit
}

deploy_stage() {
    echo "Running deploy stage"
    # Add any custom actions you want to perform when a new change is detected

}

get_last_deployed_commit
get_latest_commit

if [[ "$latest_commit" != "$last_commit" ]]; then
    echo "A new change has been pushed"

    build_stage
    deploy_stage

    last_commit="$latest_commit"
fi

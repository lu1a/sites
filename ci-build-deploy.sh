#!/bin/bash

# Set your GitHub username and repository name
USERNAME="lu1a"
REPO_NAME="portfolio-site"

# URL of the GitHub repository's main branch
GITHUB_URL="https://github.com/${USERNAME}/${REPO_NAME}/commits/main"

RELEASE_FOLDER="/root/Repositories/portfolio-site/target/release"

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

    cargo build --manifest-path=/root/Repositories/portfolio-site/Cargo.toml --release --bin portfolio-site
    mv $RELEASE_FOLDER/portfolio-site $RELEASE_FOLDER/portfolio-site-$LATEST_COMMIT
    chmod 700 $RELEASE_FOLDER/portfolio-site-$LATEST_COMMIT
}

deploy_stage() {
    echo "Running deploy stage"


    nginx_config_file="/etc/nginx/sites-available/lewistorrington.fi"
    # Define the ports to toggle between
    port1="3000"
    port2="3001"
    new_port="3000"
    # Use grep and awk to find the proxy_pass directive and extract the port number
    proxy_pass_port=$(grep -E '^\s*proxy_pass\s+http://127.0.0.1:([0-9]+);' "$nginx_config_file" | awk -F':' '{print $NF}')
    proxy_pass_port="${proxy_pass_port%;}"
    # Check the extracted port number and toggle between port1 and port2
    if [ "$proxy_pass_port" == "$port1" ]; then
        # Toggle to port2
        new_port="$port2"
    elif [ "$proxy_pass_port" == "$port2" ]; then
        # Toggle to port1
        new_port="$port1"
    else
        echo "Error: Port number not found or does not match expected values."
        exit 1
    fi
    echo "Current port: $proxy_pass_port"
    echo "Toggled port: $new_port"

    # Create and run a new service for the newly built commit
    new_service_contents=$(cat <<EOF
[Unit]
Description=portfolio-site service
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=$RELEASE_FOLDER/portfolio-site-$LATEST_COMMIT $new_port /root/Repositories/portfolio-site/static

[Install]
WantedBy=multi-user.target
EOF
    )
    echo "$new_service_contents" > /etc/systemd/system/portfolio-site-$LATEST_COMMIT.service
    systemctl start portfolio-site-$LATEST_COMMIT
    systemctl enable portfolio-site-$LATEST_COMMIT

    sed -i "s|\(^\s*proxy_pass\s+http://127.0.0.1:\)[0-9]\+;|\1$new_port;|" "$nginx_config_file"

    systemctl disable portfolio-site-$LAST_DEPLOYED_COMMIT
    systemctl stop portfolio-site-$LAST_DEPLOYED_COMMIT
    rm /etc/systemd/system/portfolio-site-$LAST_DEPLOYED_COMMIT.service

    rm $RELEASE_FOLDER/portfolio-site-$LAST_DEPLOYED_COMMIT
}

get_last_deployed_commit
get_latest_commit

if [[ "$LATEST_COMMIT" != "$LAST_DEPLOYED_COMMIT" ]]; then
    echo "A new change has been pushed"

    build_stage
    deploy_stage
fi

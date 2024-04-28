#!/bin/bash

# Set your GitHub username and repository name
USERNAME="lu1a"
REPO_NAME="portfolio-site"

# URL of the GitHub repository's main branch
GITHUB_URL="https://github.com/${USERNAME}/${REPO_NAME}/commits/main"

REPO_FOLDER="/root/Repositories/${REPO_NAME}"
RELEASE_FOLDER="${REPO_FOLDER}/target/release"

NGINX_CONFIG_FILE="/etc/nginx/sites-available/lewistorrington.fi"
DESIRED_PORT=3000
SYSTEMD_CONFIG_FOLDER="/etc/systemd/system"

LAST_DEPLOYED_COMMIT=""
LATEST_COMMIT=""

get_last_deployed_commit() {
    file_path=$(find $RELEASE_FOLDER -type f -name "${REPO_NAME}-*" -print -quit)

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
    git -C $REPO_FOLDER pull
    LATEST_COMMIT=$(git -C $REPO_FOLDER rev-parse HEAD)
    echo "Latest commit on GitHub: $LATEST_COMMIT"
}

build_stage() {
    echo "Running build stage"

    cargo build --manifest-path=$REPO_FOLDER/Cargo.toml --release --bin $REPO_NAME
    mv $RELEASE_FOLDER/$REPO_NAME $RELEASE_FOLDER/$REPO_NAME-$LATEST_COMMIT
    chmod 700 $RELEASE_FOLDER/$REPO_NAME-$LATEST_COMMIT
}

deploy_stage() {
    echo "Running deploy stage"

    # Define the ports to toggle between
    port1="$((DESIRED_PORT))"
    port2="$((DESIRED_PORT + 1))"
    port3="$((DESIRED_PORT + 2))"
    new_port="$((DESIRED_PORT))"
    # Use grep and awk to find the proxy_pass directive and extract the port number
    proxy_pass_port=$(grep -E '^\s*proxy_pass\s+http://127.0.0.1:([0-9]+);' "$NGINX_CONFIG_FILE" | awk -F':' '{print $NF}')
    proxy_pass_port="${proxy_pass_port%;}"
    # Check the extracted port number and toggle between port1 and port2
    if [ "$proxy_pass_port" == "$port1" ]; then
        # Increment to port2
        new_port="$port2"
    elif [ "$proxy_pass_port" == "$port2" ]; then
        # Increment to port3
        new_port="$port3"
    elif [ "$proxy_pass_port" == "$port3" ]; then
        # Wrap to port1
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
Description=$REPO_NAME service
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=$RELEASE_FOLDER/$REPO_NAME-$LATEST_COMMIT $new_port $REPO_FOLDER/static

[Install]
WantedBy=multi-user.target
EOF
    )
    echo "$new_service_contents" > $SYSTEMD_CONFIG_FOLDER/$REPO_NAME-$LATEST_COMMIT.service
    systemctl start $REPO_NAME-$LATEST_COMMIT
    systemctl enable $REPO_NAME-$LATEST_COMMIT

    # Wait 5 seconds for the new service to properly start up
    sleep 5

    sed -i "s|^\([[:space:]]*proxy_pass[[:space:]]\+http://127.0.0.1:\)[0-9]\+;|\1$new_port;|" "$NGINX_CONFIG_FILE"
    nginx -t && nginx -s reload

    previous_deployments=( "$SYSTEMD_CONFIG_FOLDER"/$REPO_NAME-*.service )

    # Loop over the files, excluding the one with the specific commit hash
    for file in "${previous_deployments[@]}"; do
        servicename=$(basename "$file")
        if [[ "$servicename" != "portfolio-site-$LATEST_COMMIT.service" ]]; then
            echo "Deleting previous deployment: $servicename"
            # Extract commit hash from filename
            commit_hash="${servicename#$REPO_NAME-}"  # Remove prefix "$REPO_NAME-"
            commit_hash="${commit_hash%.service}"       # Remove suffix ".service"
            # Add your processing logic here (e.g., perform actions on "$file")
            systemctl disable $REPO_NAME-$commit_hash
            systemctl stop $REPO_NAME-$commit_hash
            rm $SYSTEMD_CONFIG_FOLDER/$REPO_NAME-$commit_hash.service

            rm $RELEASE_FOLDER/$REPO_NAME-$commit_hash
        fi
    done
    systemctl daemon-reload
}

get_last_deployed_commit
get_latest_commit

if [[ "$LATEST_COMMIT" != "$LAST_DEPLOYED_COMMIT" ]]; then
    echo "A new change has been pushed"

    build_stage
    deploy_stage
fi

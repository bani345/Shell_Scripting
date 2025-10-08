#!/bin/bash

echo "****** DEPLOYMENT START *******"

# Clone the repo if not present
code_clone() {
    if [ -d "django-notes-app" ]; then
        echo "Code directory already exists. Skipping clone."
    else
        echo "Cloning the Django app..."
        git clone https://github.com/LondheShubham153/django-notes-app.git || {
            echo "Failed to clone repo"
            exit 1
        }
    fi
    cd django-notes-app || exit 1
}

# Install dependencies only if missing
install_requirements() {
    echo "Checking Docker and Nginx..."
    
    if ! command -v docker &> /dev/null; then
        echo "Installing Docker..."
        sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    else
        echo "Docker already installed. Skipping..."
    fi

    if ! command -v nginx &> /dev/null; then
        echo "Installing Nginx..."
        sudo apt-get install -y nginx
    else
        echo "Nginx already installed. Skipping..."
    fi
}

# Restart services
required_restart() {
    echo "Restarting services..."
    sudo chown "$USER" /var/run/docker.sock
    sudo systemctl enable docker
    sudo systemctl enable nginx
    sudo systemctl restart docker
    sudo systemctl restart nginx
}

# Deploy Django app
deploy() {
    echo "Deploying Django app..."
    docker build -t notes-app . || { echo "Docker build failed"; exit 1; }
    docker run -d -p 8000:8000 notes-app:latest || { echo "Docker run failed"; exit 1; }
}

# Main script execution
code_clone
install_requirements
required_restart
deploy

echo "****** DEPLOYMENT DONE *******"


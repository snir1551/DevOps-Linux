#!/bin/bash

echo "🚀 Terraform Setup Script"
echo "========================="
echo "1) Install Terraform"
echo "2) Uninstall Terraform"
echo ""

read -p "Choose an option [1-2]: " action

if [[ "$action" == "1" ]]; then
    if command -v terraform &> /dev/null; then
        echo "Terraform is already installed!"
        terraform -v
        exit 0
    fi

    echo "Updating package list..."
    sudo apt-get update -y

    echo "Installing required dependencies (gnupg, software-properties-common, curl)..."
    sudo apt-get install -y gnupg software-properties-common curl

    echo "Downloading and adding HashiCorp GPG key..."
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

    echo "Adding HashiCorp APT repository to sources list..."
    DISTRO=$(lsb_release -cs)
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${DISTRO} main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

    echo "Updating package list after adding HashiCorp repo..."
    sudo apt-get update -y

    echo "Installing Terraform..."
    LATEST_VERSION=$(apt-cache madison terraform | awk '{print $3}' | sort -Vr | head -n1)
    sudo apt-get install -y terraform=$LATEST_VERSION


    echo ""
    echo "Terraform installation complete:"
    terraform -v

elif [[ "$action" == "2" ]]; then
    if ! command -v terraform &> /dev/null; then
        echo "⚠️ Terraform is not installed."
        exit 0
    fi

    echo "Removing Terraform..."
    sudo apt-get remove --purge -y terraform

    echo "Removing HashiCorp repository and GPG key..."
    sudo rm -f /etc/apt/sources.list.d/hashicorp.list
    sudo rm -f /usr/share/keyrings/hashicorp-archive-keyring.gpg

    echo "Updating package list after cleanup..."
    sudo apt-get update -y

    echo "Terraform and related components were successfully removed."

else
    echo "Invalid option. Please choose 1 or 2."
    exit 1
fi


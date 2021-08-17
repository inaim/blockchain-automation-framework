#!/bin/bash
set -e

echo "Starting build process..."

echo "Adding env variables..."
export PATH=/root/bin:$PATH

#Path to k8s config file
KUBECONFIG=~/.kube/config

echo "Validatin network yaml"
ajv validate -s blockchain-automation-framework/platforms/network-schema.json -d blockchain-automation-framework/build/network.yaml

echo "Running the playbook..."
exec ~/Library/Python/3.8/bin/ansible-playbook -vv blockchain-automation-framework/platforms/shared/configuration/site.yaml --inventory-file=blockchain-automation-framework/platforms/shared/inventory/ -e "@blockchain-automation-framework/build/network.yaml" -e 'ansible_python_interpreter=/usr/bin/python3'

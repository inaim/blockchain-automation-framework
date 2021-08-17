#!/bin/bash
set -e

echo "Starting build process..."

echo "Adding env variables..."
export PATH=/root/bin:$PATH

#Path to k8s config file
KUBECONFIG=~/.kube/config

echo "Validatin network yaml"
ajv validate -s platforms/network-schema.json -d build/network.yaml

echo "Running the playbook..."
exec ~/Library/Python/3.8/bin/ansible-playbook -vv platforms/shared/configuration/site.yaml --inventory-file=platforms/shared/inventory/ -e "@build/network.yaml" -e 'ansible_python_interpreter=/usr/bin/python3'

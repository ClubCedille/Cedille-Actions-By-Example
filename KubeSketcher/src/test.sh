#!/bin/sh

# Path to the root directory to start the search
ROOT_DIR="/home/sonoflope/github/Plateforme-Cedille/apps"

# Recursively find all .yaml and .yml files
CHANGED_YAMLS=$(find $ROOT_DIR -type f \( -name "*.yaml" -o -name "*.yml" \))

# Get namespaces from the YAML files
NAMESPACES=$(./find-namespaces $CHANGED_YAMLS)

# Generate diagrams for each namespace
for NS in $NAMESPACES; do
    k8sviz -n $NS -t png -o ${NS}_diagram.png
done

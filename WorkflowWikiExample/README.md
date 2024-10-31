# Custom GitHub Action: Print Message

This repository contains a custom GitHub Action that prints a specified message to the console. This action demonstrates how to create and use custom actions in a GitHub workflow.

## Overview

This action takes a single input (`message`) and outputs it to the console. It can be useful for logging or other custom messaging needs in GitHub Actions workflows.

## Files

- **`action.yml`**: Defines the action, including its inputs, description, and runtime environment.
- **`index.js`**: The JavaScript file that executes the action logic. It retrieves the `message` input and logs it to the console.

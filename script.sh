#!/bin/bash
set -x
# Read user input for the new branch name
new_branch_name="${BRANCH_NAME}"
# Read user input for the selected branch to clone
selected_branch="${Branch_to_clone}"
# Check if the new branch name is provided
if [ -z "${new_branch_name}" ]; then
  echo "ERROR: Branch name is required. Please enter a branch name."
  exit 1
fi
# Check if the selected branch is provided
if [ -z "${Branch_to_clone}" ]; then
  echo "ERROR: Selected branch is required. Please select a branch."
  exit 1
fi
# Fetch the latest changes from the remote
git fetch origin
# Checkout the selected branch
git checkout "${Branch_to_clone}"
# Print current branch for reference
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch is: ${current_branch}"
# Create the new branch from the selected branch
git checkout -b "${new_branch_name}"
# Verify the new branch creation
created_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "${created_branch}" == "${new_branch_name}" ]; then
  echo "Successfully created branch: ${new_branch_name}"
else
  echo "Error: Failed to create branch: ${new_branch_name}"
  exit 1
fi
# Push the new branch to the remote repository
git push origin "${new_branch_name}"
# Verify the branch has been pushed
if [ $? -eq 0 ]; then
  echo "Successfully pushed branch: ${new_branch_name} to remote"
else
  echo "Error: Failed to push branch: ${new_branch_name} to remote"
  exit 1
fi

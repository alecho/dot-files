#!/bin/bash

echo "This doesn't seem to work because of sandboxing."

cat ~/dot-files/Vimari/userSettings.json | pbcopy

echo "Copied userSettings.json to clipboard. Paste it in Vimari.app/"

exit 1
# Path of the original file
source="~/dot-files/Vimari/userSettings.json"

# Destination
destination="~/Library/Containers/net.televator.Vimari.SafariExtension/Data/Library/userSettings.json"

# Show diff using delta
echo "Showing diff using delta:"
delta $source $destination

# Ask for user confirmation
read -p "Do you want to continue? (y/N): " response

# Copy files if user confirms
if [[ $response == "y" || $response == "Y" ]]; then
  cp $original_file $destination_path >/dev/null 2>&1
  # Check the exit code of the cp command
  if [ $? -eq 0 ]; then
    echo "File copied successfully."
  else
    echo "Failed to copy the file."
  fi
else
  echo "No action taken."
fi


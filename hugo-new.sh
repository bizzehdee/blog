#!/bin/bash

# Get the title from the first command-line argument
title="$1"

# List of short words to exclude
shortWords=("the" "a" "in" "on" "is" "and" "for" "of")

# Convert title to lowercase and split into words
result=$(echo "$title" | tr '[:upper:]' '[:lower:]')
words=($result)

# Filter out short words and join remaining words with a space
filteredWords=()
for word in "${words[@]}"; do
  skip=false
  for shortWord in "${shortWords[@]}"; do
    if [[ "$word" == "$shortWord" ]]; then
      skip=true
      break
    fi
  done
  if ! $skip; then
    filteredWords+=("$word")
  fi
done

result=$(IFS=" "; echo "${filteredWords[*]}")

# Remove non-alphanumeric characters (except spaces)
result=$(echo "$result" | sed 's/[^a-z0-9[:space:]]//g')

# Replace spaces with hyphens
result=$(echo "$result" | sed 's/[[:space:]]/-/g')

# Construct the Hugo command
Command="hugo" # Assuming hugo is in your PATH
Parms="new ${result}.md"

# Execute the command
"$Command" $Parms


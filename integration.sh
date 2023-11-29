#!/usr/bin/env bash

packages=(
  "anytype"
  "betterlockscreen"
  "azote"
  # ... rest of the packages
  "yad"
)

json_data=()

# Calculate the total number of packages
total_packages=${#packages[@]}

# Initialize the progress counter
progress_counter=0

for package in "${packages[@]}"; do
  url="https://aur.archlinux.org/packages/${package}/"
  response=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  if [[ $response -eq 200 ]]; then
    is_arch_dependant=true
    alternatives='{"debian": {}, "ubuntu": {}}'
  else
    is_arch_dependant=false
    alternatives='{"debian": {}, "ubuntu": {}}'
  fi

  package_data="{\"name\": \"$package\", \"URL\": \"$url\", \"isArchDependant\": $is_arch_dependant, \"alternatives\": $alternatives}"
  json_data+=("$package_data")

  # Increment the progress counter
  ((progress_counter++))

  # Calculate the progress percentage
  progress_percentage=$((progress_counter * 100 / total_packages))

  # Print the progress bar
  echo "Progress: $progress_percentage% [$(seq -s '=' $((progress_percentage / 2)) | tr -d '[:digit:]')>$(seq -s ' ' $(((100 - progress_percentage) / 2)) | tr -d '[:digit:]')]"

done

json_output="["
for ((i = 0; i < ${#json_data[@]}; i++)); do
  json_output+="${json_data[$i]}"
  if [[ $i -ne $((${#json_data[@]} - 1)) ]]; then
    json_output+=","
  fi
done
json_output+="]"

echo "$json_output" >packages.json

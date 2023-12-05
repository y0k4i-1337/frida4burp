#!/usr/bin/env bash

# Check if third party scripts are up to date based on their hash
# If not, update them
# Parameters:
#   $1: remote_base_url: The base URL to check for updates
#   $2: local_base_url: The base URL to check for updates
#   $3: files: The files to check for updates
update_external() {
    local remote_base_url="${1}"
    local local_base_url="${2}"
    local files=("${@:3}")
    for file in "${files[@]}"; do
        local remote_hash=$(curl -s "${remote_base_url}/${file}" | shasum -a 256 | cut -d ' ' -f 1)
        local local_hash=$(cat "${local_base_url}/${file}" | shasum -a 256 | cut -d ' ' -f 1)

        if [ "${remote_hash}" != "${local_hash}" ]; then
            echo "Updating ${file}"
            curl -s "${remote_base_url}/${file}" >"${local_base_url}/${file}"
        else
            echo "${file} is up to date"
        fi
    done
}

# Function to parse JSON from projects on frida codeshare
# and create a file with the content of the "source" property
# Parameters:
#   $1: project: The project to download (e.g. dzonerzy/fridantiroot)
#   $2: dst_dir: The destination directory to save the file
parse_json_and_create_file() {
    local project="${1}"
    local dst_dir="${2}"

    local base_url="https://codeshare.frida.re/api/project"

    # Download JSON from the URL
    local json=$(curl -s "${base_url}/${project}")

    # Extract the value of the "source" property
    local source=$(echo "${json}" | jq -r '.source')

    # Extract the value of the "project_name" property
    local project_name=$(echo "${json}" | jq -r '.project_name')

    # Create a file with the content of the "source" property
    echo "${source}" >"${dst_dir}/${project_name}.js"
}

DEPENDENCIES=(
    "jq"
    "curl"
    "shasum"
)

# Check if dependencies are installed
for dependency in "${DEPENDENCIES[@]}"; do
    if ! command -v "${dependency}" &>/dev/null; then
        echo "${dependency} could not be found"
        exit 1
    fi
done

REMOTE_BASE_URL="https://raw.githubusercontent.com/httptoolkit/frida-interception-and-unpinning/main"
LOCAL_BASE_URL="."

FILES=(
    "config.js"
    "native-connect-hook.js"
    "android/android-certificate-unpinning-fallback.js"
    "android/android-certificate-unpinning.js"
    "android/android-proxy-override.js"
    "android/android-system-certificate-injection.js"
)

update_external "${REMOTE_BASE_URL}" "${LOCAL_BASE_URL}" "${FILES[@]}"

# Download  scripts from frida codeshare (android)
CODESHARE_SCRIPTS=(
    "dzonerzy/fridantiroot"
    "akabe1/frida-multiple-unpinning"
)

for script in "${CODESHARE_SCRIPTS[@]}"; do
    echo "Downloading project @${script} from frida codeshare to ${LOCAL_BASE_URL}/android"
    parse_json_and_create_file "${script}" "${LOCAL_BASE_URL}/android"
done

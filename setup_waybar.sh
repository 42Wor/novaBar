#!/usr/bin/env bash

# --- Configuration ---
DEFAULT_THEME_NAME="novaBar"
# --- End Configuration ---

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
REPO_THEMES_ROOT_DIR="${SCRIPT_DIR}/waybar_themes"

# Destination XDG directories
XDG_CONFIG_WAYBAR_DIR="${HOME}/.config/waybar"
DEST_LAYOUTS_DIR="${XDG_CONFIG_WAYBAR_DIR}/layouts"
DEST_STYLES_DIR="${XDG_CONFIG_WAYBAR_DIR}/styles"
DEST_MODULES_DIR="${XDG_CONFIG_WAYBAR_DIR}/modules"
DEST_INCLUDES_DIR="${XDG_CONFIG_WAYBAR_DIR}/includes"

# Function to quietly copy files/directories
# Returns 0 on success, 1 on source not found, 2 on copy error
quiet_copy() {
    local src_path="$1"
    local dest_path="$2"
    local item_type="$3" # "file" or "directory_contents"

    if [ "$item_type" == "file" ]; then
        [ ! -f "$src_path" ] && return 1 # Source not found
        mkdir -p "$(dirname "$dest_path")" &>/dev/null
        cp "$src_path" "$dest_path" &>/dev/null
        [ $? -ne 0 ] && return 2 # Copy error
        return 0
    elif [ "$item_type" == "directory_contents" ]; then
        [ ! -d "$src_path" ] && return 1 # Source dir not found
        if [ "$(ls -A "$src_path" 2>/dev/null)" ]; then # Check if dir is not empty
            mkdir -p "$dest_path" &>/dev/null
            cp -r "${src_path}/"* "${dest_path}/" &>/dev/null
            [ $? -ne 0 ] && return 2 # Copy error
        else
            return 3 # Source directory empty, considered a non-critical skip
        fi
        return 0
    fi
    return 1 # Should not happen
}

# Determine theme to install
THEME_TO_INSTALL="${1:-$DEFAULT_THEME_NAME}"
REPO_THEME_PATH="${REPO_THEMES_ROOT_DIR}/${THEME_TO_INSTALL}"

if [ ! -d "$REPO_THEME_PATH" ]; then
    echo "Error: Theme '$THEME_TO_INSTALL' not found."
    exit 1
fi

echo "Setting up Waybar theme: '${THEME_TO_INSTALL}'..."

# Create base destination directories (silently)
mkdir -p "${DEST_LAYOUTS_DIR}" &>/dev/null
mkdir -p "${DEST_STYLES_DIR}" &>/dev/null
mkdir -p "${DEST_MODULES_DIR}" &>/dev/null
mkdir -p "${DEST_INCLUDES_DIR}" &>/dev/null

# Track overall success
SETUP_SUCCESS=true

# Copy Layout
quiet_copy "${REPO_THEME_PATH}/layouts/${THEME_TO_INSTALL}/config.jsonc" \
             "${DEST_LAYOUTS_DIR}/${THEME_TO_INSTALL}/config.jsonc" "file"
COPY_STATUS=$?
if [ $COPY_STATUS -ne 0 ]; then
    [ $COPY_STATUS -eq 1 ] && echo "  - Layout config: Source not found."
    [ $COPY_STATUS -eq 2 ] && echo "  - Layout config: Copy failed."
    SETUP_SUCCESS=false
fi

# Copy Style
quiet_copy "${REPO_THEME_PATH}/styles/${THEME_TO_INSTALL}/style.css" \
             "${DEST_STYLES_DIR}/${THEME_TO_INSTALL}/style.css" "file"
COPY_STATUS=$?
if [ $COPY_STATUS -ne 0 ]; then
    [ $COPY_STATUS -eq 1 ] && echo "  - Style config: Source not found."
    [ $COPY_STATUS -eq 2 ] && echo "  - Style config: Copy failed."
    SETUP_SUCCESS=false
fi

# Copy Custom Modules (if any)
quiet_copy "${REPO_THEME_PATH}/modules" \
             "${DEST_MODULES_DIR}" "directory_contents"
COPY_STATUS=$?
if [ $COPY_STATUS -eq 2 ]; then # Only report actual copy errors for dirs
    echo "  - Custom modules: Copy failed."
    SETUP_SUCCESS=false
fi

# Copy Include Files (if any)
quiet_copy "${REPO_THEME_PATH}/includes" \
             "${DEST_INCLUDES_DIR}" "directory_contents"
COPY_STATUS=$?
if [ $COPY_STATUS -eq 2 ]; then # Only report actual copy errors for dirs
    echo "  - Include files: Copy failed."
    SETUP_SUCCESS=false
fi

if [ "$SETUP_SUCCESS" = true ]; then
    echo "Theme '${THEME_TO_INSTALL}' setup complete."
    echo "Next: Select via HyDE or activate manually & restart Waybar."
else
    echo "Theme '${THEME_TO_INSTALL}' setup encountered errors. Please check messages above."
fi
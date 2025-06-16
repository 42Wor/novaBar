#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source theme files from the repository
REPO_THEME_DIR="${SCRIPT_DIR}/waybar_theme_novaBar"

# Destination XDG directories for Waybar
XDG_CONFIG_WAYBAR_DIR="${HOME}/.config/waybar"
DEST_LAYOUTS_DIR="${XDG_CONFIG_WAYBAR_DIR}/layouts"
DEST_STYLES_DIR="${XDG_CONFIG_WAYBAR_DIR}/styles"
DEST_MODULES_DIR="${XDG_CONFIG_WAYBAR_DIR}/modules"
DEST_INCLUDES_DIR="${XDG_CONFIG_WAYBAR_DIR}/includes"

# Theme name (must match the subdirectory names in the repo)
THEME_NAME="novaBar"

echo "Setting up 'novaBar' Waybar theme..."

# Create destination directories if they don't exist
mkdir -p "${DEST_LAYOUTS_DIR}/${THEME_NAME}"
mkdir -p "${DEST_STYLES_DIR}/${THEME_NAME}"
mkdir -p "${DEST_MODULES_DIR}" # Create base modules dir
mkdir -p "${DEST_INCLUDES_DIR}" # Create base includes dir

echo ""
echo "Copying layout configuration..."
if [ -f "${REPO_THEME_DIR}/layouts/${THEME_NAME}/config.jsonc" ]; then
    cp -v "${REPO_THEME_DIR}/layouts/${THEME_NAME}/config.jsonc" "${DEST_LAYOUTS_DIR}/${THEME_NAME}/config.jsonc"
else
    echo "  ERROR: Source layout config.jsonc not found in repository at ${REPO_THEME_DIR}/layouts/${THEME_NAME}/config.jsonc"
fi

echo ""
echo "Copying style configuration..."
if [ -f "${REPO_THEME_DIR}/styles/${THEME_NAME}/style.css" ]; then
    cp -v "${REPO_THEME_DIR}/styles/${THEME_NAME}/style.css" "${DEST_STYLES_DIR}/${THEME_NAME}/style.css"
else
    echo "  ERROR: Source style style.css not found in repository at ${REPO_THEME_DIR}/styles/${THEME_NAME}/style.css"
fi

# --- Optional: Copying modules directory contents ---
if [ -d "${REPO_THEME_DIR}/modules" ]; then
    echo ""
    echo "Copying modules..."
    if [ "$(ls -A ${REPO_THEME_DIR}/modules)" ]; then # Check if directory is not empty
        cp -vr "${REPO_THEME_DIR}/modules/"* "${DEST_MODULES_DIR}/"
        echo "  Copied contents of 'modules' directory."
        echo "  IMPORTANT: Ensure your main config.jsonc correctly references these module files."
    else
        echo "  'modules' directory in repository is empty. Skipping."
    fi
fi

# --- Optional: Copying includes directory contents ---
if [ -d "${REPO_THEME_DIR}/includes" ]; then
    echo ""
    echo "Copying includes..."
     if [ "$(ls -A ${REPO_THEME_DIR}/includes)" ]; then # Check if directory is not empty
        cp -vr "${REPO_THEME_DIR}/includes/"* "${DEST_INCLUDES_DIR}/"
        echo "  Copied contents of 'includes' directory."
        echo "  IMPORTANT: Ensure your main style.css or config.jsonc correctly references these include files."
    else
        echo "  'includes' directory in repository is empty. Skipping."
    fi
fi

echo ""
echo "---------------------------------------------------------------------"
echo "Setup complete for 'novaBar' theme."
echo "---------------------------------------------------------------------"
echo ""
echo "Next Steps:"
echo "1. If HyDE's waybar.py is managing your Waybar:"
echo "   Run: /home/m/.local/lib/hyde/waybar.py --select"
echo "   And choose 'novaBar/config' from the Rofi menu."
echo ""
echo "2. If you are managing Waybar manually (HyDE scripts not in use):"
echo "   a. Copy the layout directly:"
echo "      cp \"${DEST_LAYOUTS_DIR}/${THEME_NAME}/config.jsonc\" \"${XDG_CONFIG_WAYBAR_DIR}/config.jsonc\""
echo "   b. Copy the style directly (or ensure your main style.css imports it):"
echo "      cp \"${DEST_STYLES_DIR}/${THEME_NAME}/style.css\" \"${XDG_CONFIG_WAYBAR_DIR}/style.css\""
echo "      (The HyDE waybar.py script normally handles style composition with user-style.css etc.)"
echo "   c. Then, restart Waybar (e.g., killall waybar; waybar & disown)."
echo ""
echo "Consider adding an alias or putting this script in your PATH for easier access."
echo "---------------------------------------------------------------------"
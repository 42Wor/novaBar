# My Custom Waybar Themes

This repository contains custom Waybar themes and a script to install them.

## Current Themes

*   **novaBar**: A feature-rich top bar with a modern look.

## Prerequisites

*   Waybar installed.
*   Nerd Font installed (e.g., JetBrainsMono Nerd Font).
*   Dependencies for specific modules used in the chosen theme (see theme's `config.jsonc` for hints, e.g., `rofi`, `pavucontrol`, `brightnessctl`).
*   (Optional) If using HyDE project's `waybar.py` for management.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone <your-github-repo-url> my-waybar-setup
    cd my-waybar-setup
    ```

2.  **Run the setup script:**
    To install the default theme (`novaBar`):
    ```bash
    chmod +x setup_waybar.sh
    ./setup_waybar.sh
    ```
    To install a specific theme (if you add more later, e.g., `anotherTheme`):
    ```bash
    ./setup_waybar.sh anotherTheme
    ```
    The script copies the theme files to `~/.config/waybar/`.

## Activation

After running the setup script for your desired theme (e.g., `novaBar`):

*   **If using HyDE's `waybar.py`:**
    Run `/home/m/.local/lib/hyde/waybar.py --select` and choose `novaBar/config` (or the equivalent for your chosen theme).
*   **Manual Activation:**
    1.  Copy layout: `cp ~/.config/waybar/layouts/novaBar/config.jsonc ~/.config/waybar/config.jsonc`
    2.  Copy style: `cp ~/.config/waybar/styles/novaBar/style.css ~/.config/waybar/style.css`
    3.  Restart Waybar: `killall waybar; waybar & disown`

## Customization

*   Edit theme files within the `waybar_themes/<ThemeName>/` directory in this repository.
*   After changes, re-run `./setup_waybar.sh <ThemeName>` and reactivate.
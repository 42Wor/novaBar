# My Custom Waybar Setup - novaBar (Top Bar)

This repository contains my personal Waybar configuration, "novaBar", designed as a feature-rich top bar, and a script to easily set it up.

## Features of novaBar (Top Bar)

*   **Top-Left:** App Launcher, CPU, Memory, Disk usage. (Placeholder for dynamic open app icons).
*   **Top-Middle:** Hyprland Workspaces, Active Window Title.
*   **Top-Right:** Network, Audio (output & mic), Backlight, Update Indicator, System Tray, Clock, Power Menu.
*   Modern look and feel, inspired by Catppuccin Macchiato.

## Prerequisites

*   Waybar installed.
*   Hyprland (for `hyprland/workspaces` and `hyprland/window`).
*   Nerd Font installed (e.g., JetBrainsMono Nerd Font) for icons.
*   `rofi` (for launcher and power menu).
*   `pavucontrol` (for audio control click).
*   `brightnessctl` (for backlight scroll).
*   `nm-connection-editor` (for network click).
*   A script at `~/.config/waybar/scripts/check_updates.sh` for the `custom/updates` module. This script should output JSON, e.g., `{"text": "5", "tooltip": "5 packages to update", "class": "pending"}`.
*   A Rofi power menu script/config for the `custom/power_top_right` module.
*   (Optional) If using the HyDE project's `waybar.py` for management, ensure it's set up.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone <your-github-repo-url> my-waybar-setup
    cd my-waybar-setup
    ```

2.  **Run the setup script:**
    This script copies the "novaBar" theme files to `~/.config/waybar/`.
    ```bash
    chmod +x setup_waybar.sh
    ./setup_waybar.sh
    ```

## Activation

Follow the instructions printed by `setup_waybar.sh`:

**Method 1: If using HyDE's `waybar.py`:**

*   Run the Waybar layout selector:
    ```bash
    /home/m/.local/lib/hyde/waybar.py --select
    ```
*   Choose `novaBar/config` from the Rofi menu.

**Method 2: Manual Activation:**

*   Copy the layout:
    ```bash
    cp ~/.config/waybar/layouts/novaBar/config.jsonc ~/.config/waybar/config.jsonc
    ```
*   Copy the style:
    ```bash
    cp ~/.config/waybar/styles/novaBar/style.css ~/.config/waybar/style.css
    ```
*   Restart Waybar:
    ```bash
    killall waybar; waybar & disown
    ```

## Customization

*   **Main Configuration:** Edit `waybar_theme_novaBar/layouts/novaBar/config.jsonc` in this repository.
*   **Main Styling:** Edit `waybar_theme_novaBar/styles/novaBar/style.css` in this repository.
*   **User Overrides (CSS):** If you create `waybar_theme_novaBar/includes/user_overrides.css`, the `setup_waybar.sh` will copy it to `~/.config/waybar/includes/user_overrides.css`. HyDE's `waybar.py` is designed to then copy this to `~/.config/waybar/user-style.css`, which is imported last by the main `style.css` for final tweaks.

After changes, re-run `./setup_waybar.sh` and reactivate.

## Notes on Left-Side Elements

*   **Power Button on Left-Side Bottom:** This is difficult with a single top Waybar instance. It typically requires a second Waybar instance configured to appear on the left.
*   **Open App Icons on Left-Side Middle:** Similar to the power button, this is best handled by a dedicated dock or a second Waybar instance. The `custom/active_apps` module in this config is a placeholder and would require significant scripting to populate dynamically within a single top bar.

This setup provides a very "cool" and "useful" top bar. For the left-side elements, you'd likely need to explore running a second Waybar instance with its own configuration file, launched separately.
# ====================================================================
# MASTER SNIPPET LOADER
# ====================================================================
# This script automatically loops through your snippets directory and
# sources every '.sh' file found within its subfolders.
#
# SETUP INSTRUCTIONS:
# 1. Open your bashrc file:      nano ~/.bashrc
# 2. Paste this entire block at the very bottom of the file.
# 3. Create the directory:       mkdir -p ~/.bash-snippets/{prompt,aliases,automation,ssh}
# 4. Save your scripts (e.g., ~/.bash-snippets/prompt/toggle.sh)
# 5. Reload your terminal:       source ~/.bashrc
# ====================================================================

# Define the absolute path to your collection directory
SNIPPETS_DIR="$HOME/.bash-snippets"

if [ -d "$SNIPPETS_DIR" ]; then
    # Use standard shell globbing instead of 'find' to prevent recursive loop triggers
    # This natively checks directories safely without launching subshells
    for script in "$SNIPPETS_DIR"/*/*.sh; do
        # Ensure the file exists and is readable
        if [ -f "$script" ] && [ -r "$script" ]; then
            source "$script"
        fi
    done
    unset script
fi

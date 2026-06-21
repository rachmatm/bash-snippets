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

# Dynamically find and source all script files
if [ -d "$SNIPPETS_DIR" ]; then
    # Loop through all files ending in .sh inside the folder and subfolders
    for script in $(find "$SNIPPETS_DIR" -type f -name "*.sh" | sort); do
        # Verify the file is readable before sourcing to prevent terminal crashes
        if [ -r "$script" ]; then
            source "$script"
        fi
    done
    unset script # Clean up the loop variable from shell memory
fi

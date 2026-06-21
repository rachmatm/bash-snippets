# bash-snippets
A curated collection of modular Bash snippets, aliases, and functions to optimize terminal workflows and customize productivity.

# Setup Instructions

1. **Open your bashrc file:**
   ```bash
   nano ~/.bashrc
   ```
2. **Paste the master loader block** (shown below) at the very bottom of the file.
3. **Create the directories:**
   ```bash
   mkdir -p ~/.bash-snippets/{prompt,aliases,automation,ssh}
   #git clone git@github.com:rachmatm/bash-snippets.git ~/.bash-snippets
   ```
4. **Save your scripts** into their respective folders (e.g., `~/.bash-snippets/prompt/toggle.sh`).
5. **Reload your terminal:**
   ```bash
   source ~/.bashrc
   ```

---

# Master Snippet Loader Code

```bash
# ====================================================================
# MASTER SNIPPET LOADER
# ====================================================================

# Define the absolute path to your collection directory
SNIPPETS_DIR="\$HOME/.bash-snippets"

# Dynamically find and source all script files
if [ -d "\$SNIPPETS_DIR" ]; then
    # Loop through all files ending in .sh inside the folder and subfolders
    for script in \((find "\)SNIPPETS_DIR" -type f -name "*.sh" | sort); do
        # Verify the file is readable before sourcing to prevent terminal crashes
        if [ -r "\$script" ]; then
            source "\$script"
        fi
    done
    unset script # Clean up the loop variable from shell memory
fi
```

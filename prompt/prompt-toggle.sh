# ====================================================================
# TERMINAL PROMPT VISIBILITY TOGGLES
# ====================================================================

# Global variable to store the original prompt state across commands
ORIGINAL_PS1=""

# Function to hide user, host, and directory info
hide_prompt() {
    # Only back up if the backup variable is currently empty
    if [ -z "$ORIGINAL_PS1" ]; then
        ORIGINAL_PS1="$PS1"
    fi
    
    # Apply the minimalist prompt
    export PS1="$ "
}

# Function to restore the original prompt instantly from the variable
show_prompt() {
    # Check if a backup exists before attempting to restore
    if [ -n "$ORIGINAL_PS1" ]; then
        export PS1="$ORIGINAL_PS1"
        # Clear the backup variable so it can capture future changes
        ORIGINAL_PS1=""
    fi
}

# ====================================================================
# AUTOMATION: QUICK BACKUP UTILITIES
# ====================================================================

# Function to create an instant timestamped copy of a file or folder
# Usage: backup_file myfile.txt  -> creates myfile.txt.20260621_1955.bak
backup_file() {
    local target="$1"

    # Verify user passed an argument
    if [ -z "$target" ]; then
        echo "Error: Please specify a file or directory to back up."
        return 1
    fi

    # Check if the targeted file or directory actually exists
    if [ ! -e "$target" ]; then
        echo "Error: '$target' does not exist."
        return 1
    fi

    # Generate a timestamp (Format: YYYYMMDD_HHMM)
    local timestamp=$(date +"%Y%m%d_%H%M")
    
    # Strip trailing slashes from directory targets to keep names clean
    local clean_target="${target%/}"
    local backup_name="${clean_target}.${timestamp}.bak"

    # Perform the copy operation
    cp -r "$target" "$backup_name"
    echo "Success: Backup created at '$backup_name'"
}

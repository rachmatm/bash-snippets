# ====================================================================
# SSH: REMOTE SERVER CONNECTION SHORTCUTS
# ====================================================================

# Usage: sconn staging  (or type sconnect to read your available list)
sconn() {
    local target="$1"

    case "$target" in
        "prod")
            echo "Connecting to Production Environment..."
            ssh -i ~/.ssh/prod_key.pem ubuntu@192.168.1.50 -p 22
            ;;
        "staging")
            echo "Connecting to Staging Instance..."
            ssh developer@192.168.1.55 -p 2222
            ;;
        "raspberry")
            echo "Connecting to Home Pi..."
            ssh pi@raspberrypi.local
            ;;
        *)
            echo "Invalid target or no name specified."
            echo "Available shortcuts: prod, staging, raspberry"
            return 1
            ;;
    esac
}

# Fast autocomplete hook so pressing TAB shows your shortcut names
complete -W "prod staging raspberry" sconnect

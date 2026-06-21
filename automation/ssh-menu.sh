# ====================================================================
# AUTOMATION: INTERACTIVE SSH MENU
# ====================================================================

# Usage: Type 'sshmenu' to open the picker
sshmenu() {
    echo "================================="
    echo "     SELECT A REMOTE SERVER      "
    echo "================================="
    echo "1) Production Environment (AWS)"
    echo "2) Staging Server"
    echo "3) Raspberry Pi"
    echo "4) Exit"
    echo "================================="
    
    # Prompt the user for input
    read -p "Enter choice [1-4]: " choice

    case $choice in
        1)
            echo "Connecting to Production..."
            ssh -i ~/.ssh/prod_key.pem ubuntu@192.168.1.50
            ;;
        2)
            echo "Connecting to Staging..."
            ssh developer@192.168.1.55 -p 2222
            ;;
        3)
            echo "Connecting to Raspberry Pi..."
            ssh pi@raspberrypi.local
            ;;
        4)
            echo "Exiting menu."
            return 0
            ;;
        *)
            echo "Invalid option. Please try again."
            sshmenu # Restart the menu on invalid input
            ;;
    esac
}

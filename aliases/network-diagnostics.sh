# ====================================================================
# NETWORK DIAGNOSTIC ALIASES
# ====================================================================

alias myip="curl -s https://ifconfig.me && echo" # Get your public IPv4 address quickly
alias localip="hostname -I | awk '{print \$1}'" # Get your internal network IP address
alias pingg="ping -c 5 8.8.8.8"                 # Drop 5 fast pings to Google DNS
alias netlist="sudo ss -tulpn"                  # Clear list of all listening ports & PIDs

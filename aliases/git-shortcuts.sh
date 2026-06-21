# ====================================================================
# GIT SHORTCUT ALIASES
# ====================================================================

# Everyday Workflows
alias gs="git status -s"                   # Short, clean status view
alias ga="git add"                         # Quick stage file
alias gaa="git add . && git status -s"     # Stage all changes and show summary
alias gc="git commit -m"                   # Quick message commit
alias gca="git commit --amend"             # Edit last commit message

# Branching & Syncing
alias gb="git branch"                      # List local branches
alias gco="git checkout"                   # Switch branches
alias gcb="git checkout -b"                # Create and switch to new branch
alias gl="git pull"                        # Pull remote changes
alias gp="git push"                        # Push local commits to remote

# History & Logging
alias glog="git log --oneline --graph --decorate" # Visual, compact commit tree
alias gd="git diff"                        # View unstaged code changes

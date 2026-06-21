# ====================================================================
# AUTOMATION: QUICK GIT PUSH STRIP WITH BRANCH CHECK
# ====================================================================

# Usage: gitpush (No parameters needed)
gitpush() {
    # 1. Protection: Ensure this is a valid Git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "❌ Error: This directory is not a Git repository."
        return 1
    fi

    # 2. Get and display the current active branch
    local current_branch=$(git branch --show-current)
    echo "================================="
    echo "🌿 Active Branch: $current_branch"
    echo "================================="

    # 3. Branch Confirmation Check at the very beginning
    read -p "❓ Are you sure you want to push to branch '$current_branch'? (y/n): " branch_confirm
    if [[ ! "$branch_confirm" =~ ^[Yy]$ ]]; then
        echo "⏸️  Workflow aborted. No changes were committed or pushed."
        return 0
    fi
    echo "✅ Branch confirmed."
    echo "---------------------------------"

    # 4. Check for local modifications before asking for a message
    if [ -z "$(git status --porcelain)" ]; then
        echo "✨ Nothing to commit. Your working tree is already perfectly clean!"
        return 0
    fi

    # 5. Interactive Prompt: Ask for the commit message
    echo "📝 Local modifications detected."
    read -p "💬 Enter your commit message: " msg

    # Fallback: Abort if you press enter without typing anything
    if [ -z "$msg" ]; then
        echo "❌ Error: Commit message cannot be empty. Workflow aborted."
        return 1
    fi

    # 6. Automated Pipeline Execution
    echo "📦 Staging all local modifications..."
    git add .

    echo "📝 Committing changes..."
    git commit -m "$msg"

    echo "📤 Pushing code to origin/$current_branch..."
    git push origin "$current_branch"

    if [ $? -eq 0 ]; then
        echo "✅ Success! Your code has been pushed cleanly."
    else
        echo "❌ Error: Failed to push to remote repository."
    fi
}

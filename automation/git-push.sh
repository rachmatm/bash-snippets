# ====================================================================
# AUTOMATION: QUICK GIT PUSH STRIP WITH BRANCH CHECK
# ====================================================================

# Usage: gitpush "Your commit message here"
gitpush() {
    local msg="$1"

    # 1. Protection: Ensure a commit message was provided immediately
    if [ -z "$msg" ]; then
        echo "❌ Error: Missing commit message."
        echo "💡 Usage: gitpush \"your commit message\""
        return 1
    fi

    # 2. Protection: Ensure this is a valid Git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "❌ Error: This directory is not a Git repository."
        return 1
    fi

    # 3. Get and display the current active branch
    local current_branch=$(git branch --show-current)
    echo "================================="
    echo "🌿 Active Branch: $current_branch"
    echo "================================="

    # 4. Branch Confirmation Check at the very beginning
    read -p "❓ Are you sure you want to push to branch '$current_branch'? (y/n): " branch_confirm
    if [[ ! "$branch_confirm" =~ ^[Yy]$ ]]; then
        echo "⏸️  Workflow aborted. No changes were committed or pushed."
        return 0
    fi
    echo "✅ Branch confirmed. Starting automated pipeline..."
    echo "---------------------------------"

    # 5. Check for local modifications before proceeding
    if [ -z "$(git status --porcelain)" ]; then
        echo "✨ Nothing to commit. Your working tree is already perfectly clean!"
        return 0
    fi

    # 6. Automated Pipeline Execution (No further prompts)
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

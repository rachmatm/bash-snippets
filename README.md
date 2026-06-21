# bash-snippets
A curated collection of modular Bash snippets, aliases, and functions to optimize terminal workflows and customize productivity.

## Setup Instructions

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

## Reloading Changes: source vs exec bash

When I update my snippets or modify my `~/.bashrc`, I need to reload the shell configuration. While running `source ~/.bashrc` is common, using `exec bash` is much safer when managing and testing new shell scripts.

### Why I use `exec bash` instead of `source`

* **Complete Memory Reset:** `source` appends new changes *on top* of the active session. It cannot erase old, broken shell functions, corrupted variables, or background loops. `exec bash` kills the old shell process entirely and swaps it with a brand-new instance, wiping the slate clean.
* **Prevents Environment Stacking:** If my scripts modify environmental configurations like the `$PATH` variable, running `source` repeatedly will continuously append duplicate paths. `exec bash` initializes the environment fresh, loading variables exactly once.
* **Instant Recovery:** If a faulty snippet or a recursive loop breaks or freezes my terminal session, typing `exec bash` acts as an immediate safety valve to reset the prompt to a clean state without needing to close the terminal window.

### How to use it

Whenever I make updates to my snippets or configurations, I apply them by running:

```bash
exec bash
```

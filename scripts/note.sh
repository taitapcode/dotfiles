#!/usr/bin/env bash

# --- Configuration ---
note_dir="$HOME/Documents/notes"

# --- Core Actions ---
case "${1:-}" in
  clone)
    # Check if the user provided a repository URL
    if [ -z "$2" ]; then
      echo "Error: Please provide a repository URL."
      echo "Usage: note clone <repo_url>"
      exit 1
    fi

        # Directory already exists and contains files
        if [ -d "$note_dir" ]; then
          echo "Notes directory already exists at $note_dir."

          cd "$note_dir" || exit 1
          if [ ! -d .git ]; then
            echo "Directory is not a Git repository but contains files."
            echo "Merging remote repository with your existing files..."

                # The trick to clone into an existing, non-empty directory:
                git init
                git remote add origin "$2"
                git fetch origin

                # Automatically detect the default remote branch (main or master)
                default_branch=$(git remote show origin | awk '/HEAD branch/ {print $3}')
                if [ -z "$default_branch" ]; then
                  default_branch="main" # Fallback if remote show fails
                fi

                # Pull and merge remote files while keeping local files intact
                git checkout -b "$default_branch" 2>/dev/null || git branch -M "$default_branch"
                if git pull origin "$default_branch" --allow-unrelated-histories --no-edit; then
                  echo "Successfully merged remote notes with your local files!"
                  echo "You can now run 'note push' to back up your old local files to the cloud."
                else
                  echo "Warning: Pull completed, but there might be conflicts. Please check your files."
                fi
              else
                echo "Error: This directory is already an active Git repository connected to:"
                git remote get-url origin
          fi
          cd - > /dev/null || exit 1

        # Clean slate (Directory does not exist at all)
      else
        echo "Cloning notes repository from $2..."
        if git clone "$2" "$note_dir"; then
          echo "Notes repository successfully cloned to $note_dir!"
        else
          echo "Error: Failed to clone the repository."
          exit 1
        fi
        fi
        ;;

      pull)
        cd "$note_dir" || exit 1
        if [ ! -d .git ]; then
          echo "Error: Directory is not a valid Git repository."
          exit 1
        fi
        git pull
        cd - > /dev/null || exit 1
        ;;

      push)
        cd "$note_dir" || exit 1
        if [ ! -d .git ]; then
          echo "Error: Directory is not a valid Git repository."
          exit 1
        fi
        git add .
        commit_msg=$(date "+%S:%M:%H %d/%m/%Y")
        git commit -m "$commit_msg"
        git push
        cd - > /dev/null || exit 1
        ;;

      folder)
        cd "$note_dir" || exit 1
        nvim -c "lua Snacks.picker.files()"
        ;;

      new)
        cd "$note_dir" || exit 1
        if [ -n "${2:-}" ]; then
          nvim "$2.md"
        else
          timestamp=$(date "+%M%H%d%m%Y")
          nvim "$timestamp.md"
        fi
        ;;

      *)
        if [ ! -d "$note_dir" ]; then
          mkdir -p "$note_dir"
        fi

        cd "$note_dir" || exit 1
        if [ -n "${1:-}" ]; then
          nvim "$1.md"
        else
          timestamp=$(date "+%Y%m%d")
          nvim "$timestamp.md"
        fi
        cd - > /dev/null || exit 1
        ;;
    esac

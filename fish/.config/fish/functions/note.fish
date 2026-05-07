function note
    set -l note_dir ~/Documents/notes

    if not test -d $note_dir
        mkdir -p $note_dir
    end

    switch "$argv[1]"
        case sync
            cd $note_dir
            if not test -d .git
                echo "No Git repo in this directory"
                return 1
            end
            git pull
            cd -

        case push
            cd $note_dir
            if not test -d .git
                echo "No Git repo in this directory"
                return 1
            end
            git add .
            set -l commit_msg (date "+%S:%M:%H %d/%m/%Y")
            git commit -m "$commit_msg"
            git push
            cd -

        case folder
            cd $note_dir
            nvim -c "lua Snacks.picker.files()"

        case new
            cd $note_dir
            if set -q argv[2]
                nvim argv[2].md
            else
                set -l timestamp (date "%M%H%d%m%Y")
                nvim $timestamp.md
            end

        case "*"
            cd $note_dir
            if test -n "$argv[1]"
                nvim $argv[1].md
            else
                set -l timestamp (date "+%Y%m%d")
                nvim $timestamp.md
            end
    end
end

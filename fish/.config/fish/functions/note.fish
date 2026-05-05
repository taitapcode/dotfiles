function note
    set -l note_dir ~/Documents/notes

    if not test -d $note_dir
        mkdir -p $note_dir
    end

    switch "$argv[1]"
        case sync
            # Kéo dữ liệu mới nhất từ remote về
            cd $note_dir
            if not test -d .git
                echo "Chưa setup Git cho folder này."
                return 1
            end
            echo "Đang sync notes từ server..."
            git pull
            echo "Đã sync xong!"

        case push
            cd $note_dir
            if not test -d .git
                echo "Chưa setup Git."
                return 1
            end
            echo "Đang commit và push..."
            git add .
            set -l commit_msg (date "+%S:%M:%H %d/%m/%Y")
            git commit -m "$commit_msg"
            git push
            echo "Đã push thành công!"

        case folder
            cd $note_dir
            nvim -c "lua Snacks.picker.files()"

        case new
            if set -q argv[2]
                nvim $note_dir/$argv[2].md
            else
                set -l timestamp (date "%M%H%d%m%Y")
                nvim $note_dir/$timestamp.md
            end

        case "*"
            if test -n "$argv[1]"
                nvim $note_dir/$argv[1].md
            else
                set -l timestamp (date "+%Y%m%d")
                nvim $note_dir/$timestamp.md
            end
    end
end

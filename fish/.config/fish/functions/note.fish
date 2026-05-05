function note
    # Thiết lập đường dẫn thư mục Notes
    set -l note_dir ~/Documents/Notes

    # Kiểm tra và tạo thư mục nếu chưa tồn tại
    if not test -d $note_dir
        mkdir -p $note_dir
    end

    # Xử lý các subcommand
    switch "$argv[1]"
        case folder
            # Mở Neovim tại thư mục Notes và gọi Snacks picker
            cd $note_dir
            nvim -c "lua Snacks.picker.files()"

        case new
            if set -q argv[2]
                # note new {name}
                nvim $note_dir/$argv[2].md
            else
                # note new (format %S:%M:%H-%d%m%Y)
                set -l timestamp (date "+%S%M%H%d%m%Y")
                nvim $note_dir/$timestamp.md
            end

        case "*"
            if test -n "$argv[1]"
                # Trường hợp gõ 'note something' mà không có 'new'
                # Có thể tùy biến để nó hiểu là tạo note mới với {name}
                nvim $note_dir/$argv[1].md
            else
                # Lệnh 'note' mặc định: format %H%d%m%Y
                set -l timestamp (date "+%H%d%m%Y")
                nvim $note_dir/$timestamp.md
            end
    end
end

function note --description 'Create a new file in ~/Notes'
    mkdir -p ~/Notes
    set filename ~/Notes/note-(date +%H%m%d%Y)".md"
    nvim $filename
end

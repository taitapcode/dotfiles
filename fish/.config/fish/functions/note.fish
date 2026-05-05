function note --description 'Create a new file in ~/Notes'
    mkdir -p ~/Notes
    set filename ~/Notes/note-(date +%d%m%Y)".md"
    nvim $filename
end

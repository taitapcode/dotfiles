function notes --description 'Go to ~/Notes and open Neovim with Snacks file finder'
    mkdir -p ~/Notes
    cd ~/Notes
    nvim -c "lua Snacks.picker.files()"
end

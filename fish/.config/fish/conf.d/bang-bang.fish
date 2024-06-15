function _bang-bang_key_bindings --on-variable fish_key_bindings
    bind --erase !
    bind --erase '$'
    switch "$fish_key_bindings"
        case fish_default_key_bindings
            bind --mode default ! __history_previous_command
            bind --mode default '$' __history_previous_command_arguments
        case fish_vi_key_bindings fish_hybrid_key_bindings
            bind --mode insert ! __history_previous_command
            bind --mode insert '$' __history_previous_command_arguments
    end
end

_bang-bang_key_bindings

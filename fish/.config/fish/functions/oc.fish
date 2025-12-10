function oc
    if type -q opencode
        command opencode $argv
    else
        echo "OpenCode not found. Please install OpenCode to use this command."
        return 1
    end
end

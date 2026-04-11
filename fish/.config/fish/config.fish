function on_command_failed --on-event fish_postexec
    # $status contains the exit code of the last command
    # $argv[1] contains the command string that was executed

    if test $status -ne 0
        paplay --volume=32768 "/home/tai/.local/share/fahhh/fahhh.mp3" >/dev/null 2>&1 &
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

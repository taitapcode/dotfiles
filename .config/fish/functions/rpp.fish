function rpp
    for file_cpp in $argv
        if test -e $file_cpp; and test (string replace -r -- ".+\.(.+)\$" '$1' $file_cpp) = cpp
            set -l file_out (echo $file_cpp | sed 's/\.[^.]*$//')
            g++ $file_cpp -o $file_out &&
                ./$file_out &&
                rm $file_out -f
        else
            echo $file_cpp 'is not cpp file'
        end
    end
end

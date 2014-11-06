# original: http://www.linuxsysadmintutorials.com/multiple-ssh-client-configuration-files/

#ssh() {
#    TMPDIR=~/tmp
#    case "$(uname -s)" in
#        Linux)
#            tmp_fifo=$(mktemp -u --suffix=._ssh_fifo)
#            ;;
#        Darwin)
#            tmp_fifo=$(mktemp -u -t ._ssh_fifo)
#            ;;
#        *)
#            echo 'unsupported OS'
#            exit
#            ;;
#    esac
#
#    # cleanup first
#    rm ~/tmp/._ssh_fifo* 2>/dev/null
#
#    echo $tmp_fifo
#    mkfifo "$tmp_fifo"
#    cat ~/.ssh/config ~/.ssh/config.* >"$tmp_fifo" 2>/dev/null &
#    /usr/bin/ssh -F "$tmp_fifo" "$@"
#    rm "$tmp_fifo"
#}

#ssh $*

alias compile-ssh-config='echo -n > ~/.ssh/config && cat ~/.ssh/config.* > ~/.ssh/config'
alias ssh='compile-ssh-config && ssh'


#!/bin/bash

#set -xv

#function trace_line(){
#  caller
#}
#trap trace_line debug

LOGPREFIX="[agent-handler]"

### START SSH Agent handling
# stolen from http://help.github.com/ssh-key-passphrases/
SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "$LOGPREFIX Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo "$LOGPREFIX succeeded"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    test_identities
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
      for sshkey in $(find $HOME/.ssh/ -type f \( -iname "id_*" ! -iname "*.pub" \)); do
        echo "$LOGPREFIX adding $sshkey"
        ssh-add $sshkey
        if [ $? -eq 2 ];then
          start_agent
        fi
      done
    else
      echo "$LOGPREFIX the agent contains the following identities:"
      ssh-add -l
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -x "$SSH_AUTH_SOCK" ]; then
  echo "$LOGPREFIX the forwarded agent contains the following identies:"
  ssh-add -l
elif [ -n "$SSH_AGENT_PID" ]; then
  echo "$LOGPREFIX testing for PID $SSH_AGENT_PID"
  ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
  if [ $? -eq 0 ]; then
    echo "$LOGPREFIX PID $SSH_AGENT_PID runing"
    test_identities
  else
    echo "$LOGPREFIX PID $SSH_AGENT_PID not runing"
    start_agent
  fi
else
  if [ -f "$SSH_ENV" ]; then
    echo "$LOGPREFIX sourcing $SSH_ENV"
  	. "$SSH_ENV" > /dev/null
  fi
  ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
  if [ $? -eq 0 ]; then
    test_identities
  else
    start_agent
  fi
  echo "$LOGPREFIX ssh-agent with PID $SSH_AGENT_PID is running, including the following identities:"
  ssh-add -l
fi
### END SSH Agent handling


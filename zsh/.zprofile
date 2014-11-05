## manage ssh agent with keychain

# if there is a forwarded agent, use it
if [ -x "$SSH_AUTH_SOCK" ]; then
  echo "The \$SSH_AUTH_SOCK contains the following identities:"
  ssh-add -l
else
  if [ -x $HOME/.dotfiles/bin/keychain ]; then
    eval $($HOME/.dotfiles/bin/keychain --eval -q)
    sshkeys=""
    for sshkey in $(find $HOME/.ssh/ -type f \( -iname "id_*" ! -iname "*.pub" \)); do
      sshkeys="$sshkeys $sshkey"
    done
    $HOME/.dotfiles/bin/keychain -q $(echo $sshkeys)
    echo "Your ssh-agent is kindly managed by keychain. enjoy!"
    ssh-add -l
  else
    echo "keychain missing in $HOME/.dotfiles/bin/keychain"
  fi
fi


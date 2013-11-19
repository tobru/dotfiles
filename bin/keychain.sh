#!/bin/sh
################################################################################
# Load keychain to handle ssh and gpg keys
################################################################################
if [ -f /usr/bin/keychain ]; then
  if [ -f /usr/bin/ksshaskpass ]; then
    export SSH_ASKPASS=/usr/bin/ksshaskpass
  else
    export SSH_ASKPASS=/usr/bin/askpass
  fi
  /usr/bin/keychain
  . $HOME/.keychain/`hostname`-sh
  . $HOME/.keychain/`hostname`-sh-gpg
fi

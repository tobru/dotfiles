#################
### sync dotfiles
#################
dotfilesync () {
  cd $HOMe/.dotfiles
  git pull
  git push
  if [ -d $HOME/.private_dotfiles ]; do
    cd $HOME/.private_dotfiles
    git pull
    git push
  fi
  cd
}

################
## sh-remove-key
################
ssh-remove-key () {
  remove_host=$1
  ip=$(dig +short $remove_host)
  if [ -z "$ip" ]
  then
          ip=$(dig +short $remove_host.$(dnsdomainname))
  fi
  echo ssh-keygen -R "$remove_host"
  ssh-keygen -R "$remove_host"
  if [ ! -z "$ip" ]
  then
          echo ssh-keygen -R "$ip"
          ssh-keygen -R "$ip"
  fi
}


#################
### sync dotfiles
#################
dotfilesync () {
  cd $HOME/.dotfiles
  echo "running git pull in .dotfiles"
  git pull
  echo "running git push in .dotfiles"
  git push
  if [ -d $HOME/.private_dotfiles ]; then
    cd $HOME/.private_dotfiles
    echo "running git pull in .private_dotfiles"
    git pull
    echo "running git push in .private_dotfiles"
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


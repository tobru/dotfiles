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


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


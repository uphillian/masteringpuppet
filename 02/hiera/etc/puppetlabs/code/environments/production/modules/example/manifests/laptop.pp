class example::laptop {
  # collect all the ssh keys
  if $::homedir != undef {
    Sshkey <<| tag == 'login_server' |>> {
      target => "$::homedir/.ssh/known_hosts"
    }   
  } else {
    Sshkey <<| tag == 'login_server' |>>
  }
}

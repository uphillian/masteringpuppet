class example::login_server {
  if ( $::sshrsakey != undef ) {
    @@sshkey {"$::fqdn-rsa":
      host_aliases => ["$::hostname","$::ipaddress"],
      key          => "$::sshrsakey",
      type         => 'rsa',
      tag          => 'example::login_server',
    }
  }
  if ( $::sshdsakey != undef ) {
    @@sshkey {"$::fqdn-dsa":
      host_aliases => ["$::hostname","$::ipaddress"],
      key          => "$::sshdsakey",
      type         => 'dsa',
      tag          => 'example::login_server',
    }
  }
}

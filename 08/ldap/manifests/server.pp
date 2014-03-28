class ldap::server {
  @@host {"ldap-$::hostname":
    host_aliases => ["$::fqdn",'ldap'],
    ip           => "$::ipaddress",
    tag          => 'ldap-server',
  }
  Host <<| tag == 'ldap-client' |>>
}

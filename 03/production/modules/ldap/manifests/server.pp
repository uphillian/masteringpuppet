class ldap::server {
  @@host {"ldap-$::hostname":
    host_aliases => ["$::fqdn", 'ldap' ],
    ip           => $::ipaddress,
  }
  Host <<| tag == 'ldap-client' |>>
}

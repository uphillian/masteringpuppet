class base {
  Host <<| tag == 'ldap-server' |>>
  @@host {"ldap-client-$::hostname":
    host_aliases => ["$::fqdn","another-$::hostname"],
    ip           => "$::ipaddress",
    tag          => 'ldap-client',
  }
}

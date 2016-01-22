#class base {
#  $welcome = hiera('welcome', 'Welcome')
#  file {'/etc/motd':
#    mode    => '0644',
#    owner   => '0',
#    group   => '0',
#    content => inline_template("<%= @welcome %>\nManaged Node: <%= @hostname %>\nManaged by Puppet version <%= @puppetversion %>\n"),
#  }
#  @@host {"ldap-client-$::hostname":
#    host_aliases => ["$::fqdn","another-$::hostname"],
#    ip           => $::ipaddress,
#    tag          => 'ldap-client',
#  }
#  include example::dns::client
#  }
class base {
  file { 'one':
    path   => '/tmp/one',
    ensure => 'directory',
  }
#  file { 'two':
#    path   => "/tmp/one$one",
#    ensure => 'file',
#  }
}

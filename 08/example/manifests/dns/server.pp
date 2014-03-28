class example::dns::server {

  # setup bind
  package {'bind': }
  service {'named': require => Package['bind'] }

  # configure bind
  file {'/etc/named.conf':
    content => template('example/dns/named.conf.erb'),
    owner   => 0,
    group   => 'named',
    require => Package['bind'],
    notify  => Service['named']
  }

  exec {'named reload':
    refreshonly => true,
    command     => 'service named reload',
    path        => '/usr/sbin:/sbin',
    require     => Package['bind'],
  }

  # resolv.conf part, define the concat::fragment
  # export ourselves as a dnsserver
  @@concat::fragment {"resolv.conf nameserver $::hostname":
    content => "nameserver $::ipaddress\n",
    order   => 10,
    tag     => 'resolv.conf',
  }

  # zone files
  concat {'/var/named/zone.example.com':
    mode   => 0644,
    notify => Exec['named reload'],
  }
  concat {'/var/named/reverse.122.168.192.in-addr.arpa':
    mode   => 0644,
    notify => Exec['named reload'],
  }
  concat::fragment {'zone.example header':
    target  => '/var/named/zone.example.com',
    content => template('example/dns/zone.example.com.erb'),
    order   => 01,
  }
  concat::fragment {'reverse.122.168.192.in-addr.arpa header':
    target  => '/var/named/reverse.122.168.192.in-addr.arpa',
    content => template('example/dns/reverse.122.168.192.in-addr.arpa.erb'),
    order   => 01,
  }
  Concat::Fragment <<| tag == "zone.example.com" |>> {
    target => '/var/named/zone.example.com'
  }
  Concat::Fragment <<| tag == "reverse.122.168.192.in-addr.arpa" |>> {
    target => '/var/named/reverse.122.168.192.in-addr.arpa'
  }
}

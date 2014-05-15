class example::dns::client 
  (
    $domain = 'example.com',
    $search = 'prod.example.com example.com'
  ) {
  # pull settings from hiera, sensible defaults
  #  $domain = hiera('dns::domain','example.com')
  # $search = hiera('dns::search','prod.example.com example.com')

  concat {'/etc/resolv.conf':
    mode => 0644,
  }

  # search and domain settings
  concat::fragment{'resolv.conf search/domain': 
    target  => '/etc/resolv.conf',
    content => "search $search\ndomain $domain\n",
    order   => 07, 
  }

  Concat::Fragment <<| tag == 'resolv.conf' |>> {
    target => '/etc/resolv.conf'
  }
  # export ourselves to the zone file

  @@concat::fragment {"zone example $::hostname":
    content => "$::hostname A $::ipaddress\n",
    order   => 10,
    tag     => 'zone.example.com',
  }
  $lastoctet = regsubst($::ipaddress_eth0,'^([0-9]+)[.]([0-9]+)[.]([0-9]+)[.]([0-9]+)$','\4')
  @@concat::fragment {"zone reverse $::reverse_eth0 $::hostname":
    content => "$lastoctet PTR $::fqdn.\n",
    order   => 10,
    tag     => "reverse.$::reverse_eth0",
  }
}

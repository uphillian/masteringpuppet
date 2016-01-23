class example::dns::client 
  (
    String $domain = 'example.com',
    String $search = 'prod.example.com example.com'
  ) {

  concat {'/etc/resolv.conf':
    mode => '0644',
  }
  
  # search and domain settings
  concat::fragment{'resolv.conf search/domain':
    target  => '/etc/resolv.conf',
    content => "search ${search}\ndomain ${domain}\n",
    order   => '07',
  }

  Concat::Fragment <<| tag == 'resolv.conf' |>> {
    target => '/etc/resolv.conf'
  }

  @@concat::fragment {"zone example $::hostname":
    content => "${::hostname} A ${::ipaddress_enp0s8}\n",
    order   => '10',
    tag     => 'zone.example.com',
  }
  $lastoctet = regsubst($::ipaddress_enp0s8,'^([0-9]+)[.]([0-9]+)[.]([0-9]+)[.]([0-9]+)$','\4')
  @@concat::fragment {"zone reverse ${::reverse_enp0s8} ${::hostname}":
    content => "$lastoctet PTR ${::fqdn}.\n",
    order   => '10',
    tag     => "reverse.${::reverse_enp0s8}",
  }
}

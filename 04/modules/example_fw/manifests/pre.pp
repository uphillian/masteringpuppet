class example_fw::pre {
  Firewall {
    require => undef,
  }

  firewall { '000 accept all icmp':
    proto => 'icmp',
    action => 'accept',
  }
  firewall { '001 accept all to lo':
    proto => 'all',
    iniface => 'lo',
    action => 'accept',
  }
  firewall { '002 accept related established':
    proto => 'all',
    state => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
  firewall { '022 accept ssh':
    proto => 'tcp',
    port => '22',
    action => 'accept',
  }
}

class example::mcollective {
  $mcollective_server = 'puppet.example.com'
  package {'mcollective':
    ensure => true,
  }
  service {'mcollective':
    ensure  => true,
    enable  => true,
    require => [Package['mcollective'],File['mcollective_server_config']]
  }
  file {'mcollective_server_config':
    path    => '/etc/mcollective/server.cfg',
    owner   => 0,
    group   => 0,
    mode    => 0640,
    content => template('example/mcollective/server.cfg.erb'),
    require => Package['mcollective'],
    notify  => Service['mcollective'],
  }
  file {'facts.yaml':
    path     => '/etc/mcollective/facts.yaml',
    owner    => 0,
    group    => 0,
    mode     => 0640,
    loglevel => debug,
    #content => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.sort.to_yaml %>"),
    content  => inline_template("---\n<% scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.sort.each do |k, v| %>  <%= k %>: \"<%= v %>\"\n<% end %>\n"),
    require => Package['mcollective'],
  }
  file {'mcollective_server_key':
    path   => '/etc/mcollective/ssl/mcollective_public.pem',
    owner  => 0,
    group  => 0,
    mode   => 0640,
    source => 'puppet:///modules/example/mcollective/mcollective_public.pem',
  }
  file {'mcollective_server_private':
    path   => '/etc/mcollective/ssl/mcollective_private.pem',
    owner  => 0,
    group  => 0,
    mode   => 0600,
    source => 'puppet:///modules/example/mcollective/mcollective_private.pem',
  }
  file {'mcollective_clients':
    ensure  => 'directory',
    path    => '/etc/mcollective/ssl/clients',
    mode    => '0700',
    owner   => 0,
    group   => 0,
    recurse => true,
    source  => 'puppet:///modules/example/mcollective/clients',
  }

}

class web {
  package {'httpd':
    ensure => 'installed'
  }
  service {'httpd':
    ensure  => true,
    enable  => true,
    require => Package['httpd'],
  }
  include example_fw
  firewall {'080 web server':
    proto  => 'tcp',
    port   => '80',
    action => 'accept',
  }
}


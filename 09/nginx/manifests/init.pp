class nginx (
  Integer $worker_connections = 1024,
  Integer $worker_processes = 1,
  Integer $keepalive_timeout = 60,
  Enum['installed','absent'] $nginx_version = 'installed',
) {
  file {'nginx.conf':
    path    => '/etc/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
    mode    => 0644,
    owner   => '0',
    group   => '0',
    notify  => Service['nginx'],
    require => Package['nginx'],
  }
  package {'nginx':
    ensure => $nginx_version,
  }
  service {'nginx':
    require => Package['nginx'],
    ensure  => true,
    enable  => true,
  }
}

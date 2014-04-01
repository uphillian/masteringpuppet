define nginx::server (
  $server_name,
  $error_log,
  $access_log,
  $root,
  $listen = 80,
) {
  file {"nginx::server::$server_name":
    path    => "/etc/nginx/conf.d/${server_name}.conf",
    content => template('nginx/server.conf.erb'),
    mode    => 0644,
    owner   => '0',
    group   => '0',
    notify  => Service['nginx']
  }

}

define nginx::server (
  String $server_name,
  String $error_log,
  String $access_log,
  String $root,
  Integer $listen = 80,
) {
  include nginx
  file {"nginx::server::$server_name":
    path    => "/etc/nginx/conf.d/${server_name}.conf",
    content => template('nginx/server.conf.erb'),
    mode    => '0644',
    owner   => '0',
    group   => '0',
    notify  => Service['nginx'],
    require => Package['nginx']
  }

}

# profile::nginx::cdn
# cdn listens on 80 and serves out on port 80
class profile::cdn 
  (
    $listen = "80",
  ) {
  nginx::server {"profile::nginx:cdn::$::fqdn":
    server_name => "${::hostname}.cdn.example.com",
    error_log   => "/var/log/nginx/cdn-${::hostname}-error.log",
    access_log  => "/var/log/nginx/cdn-${::hostname}-access.log",
    root        => "/srv/www",
    listen      => "$listen",
  }
  file {'/srv/www':
    ensure  => 'directory',
    owner   => 'nginx',
    group   => 'nginx',
    require => Package['nginx'],
  }
  file {'/srv/www/index.html':
    mode    => '0644',
    owner   => 'nginx',
    group   => 'nginx',
    content => "<html><head><title>${::hostname} cdn node</title></head>\n<body><h1>${::hostname} cdn node</h1><h2>Sample Content</h2>\n</body></html>",
    require => [Package['nginx'],File['/srv/www']],
  }
}


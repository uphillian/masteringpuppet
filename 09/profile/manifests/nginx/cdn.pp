# profile::nginx::cdn
# cdn listens on 80 and serves out on port 80
class profile::nginx::cdn {
  nginx::server {"profile::nginx:cdn::$::fqdn":
    $server_name => "${::hostname}.cdn.example.com",
    $error_log   => "/var/log/nginx/cdn-${::hostname}-error.log",
    $access_log  => "/var/log/nginx/cdn-${::hostname}-access.log",
    $root        => "/srv/www",
  }
}

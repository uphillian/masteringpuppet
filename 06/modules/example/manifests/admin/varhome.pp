class example::admin::varhome {
  file {'/var/home':
    ensure => 'directory',
    owner  => '0',
    group  => 'admin',
    mode   => '0750',
  }
}

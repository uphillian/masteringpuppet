class base {
  file {'one':
    path   => '/tmp/one',
    ensure => 'directory',
  }
  file {'one':
    path   => '/tmp/one',
    ensure => 'file',
  }
}

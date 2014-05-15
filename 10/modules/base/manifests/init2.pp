class base {
  file {'one':
    path   => '/tmp/one',
    ensure => 'directory',
  }
  file {'two':
    path   => "/tmp/one$one",
    ensure => 'file',
  }
}

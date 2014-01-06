class virtual {
# performance tuning for virtual machine
  package {'tuned':
    ensure => 'present',
  }
  service {'tuned':
    enable => true,
    ensure => true,
    require => Package['tuned']
  }
  exec {'set tuned profile':
    command => '/usr/sbin/tuned-adm profile virtual-guest',
    unless => '/bin/grep -q virtual-guest /etc/tune-profiles/active-profile',
  }
}

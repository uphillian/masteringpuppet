class lvm_web {
  example::fs {'/var/www/html':
    vg      => 'vg_web',
    lv      => 'lv_var_www',
    pv      => '/dev/sda',
    owner   => '48',
    group   => '48',
    size    => '4G',
    mode    => '0755',
    require => File['/var/www'],
  }
  file {'/var/www':
    ensure => 'directory',
    mode   => '0755',
  }
}


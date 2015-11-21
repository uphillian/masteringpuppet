class drupal::fs {
  example::fs {'/var/www/html/drupal':
    vg      => 'vg_web',
    lv      => 'lv_drupal',
    pv      => '/dev/sda',
    owner   => '48',
    group   => '48',
    size    => '2G',
    mode    => '0755',
    require => Example::Fs['/var/www/html']
  }

}

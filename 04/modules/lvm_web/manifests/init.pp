class lvm_web {
  lvm::volume {"lv_var_www":
    ensure => 'present',
    vg     => "vg_web",
    pv     => "/dev/sda",
    fstype => "ext4",
    size   => "4G",
  }
  file {'/var/www':
    ensure => 'directory',
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }
  file {'/var/www/html':
    ensure  => 'directory',
    owner   => '48',
    group   => '48',
    mode    => '0755',
    require => File['/var/www'],
  }
  mount {'lvm_web_var_www':
    name    => '/var/www/html',
    ensure  => 'mounted',
    device  => "/dev/vg_web/lv_var_www",
    dump    => '1',
    fstype  => "ext4",
    options => "defaults",
    pass    => '2',
    target  => '/etc/fstab',
    require => [Lvm::Volume["lv_var_www"],File["/var/www/html"]],
  }
}

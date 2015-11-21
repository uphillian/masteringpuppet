define example::fs
(
  String $lv,                   # which logical volume
  String $pv,                   # which physical volume
  Number $size,                 # how big

  Enum['ext4','ext3','xfs'] $fs_type = 'ext4',     # the filesystem type
  String $mnt     = $title,   # where to mount the filesystem
  String $vg      = 'VolGroup', # which volume group
  Bool $managed   = true,       # do we create the file resource or not.
  String $owner   = '0',        # who owns the mount point
  String $group   = '0',        # which group owns the mount point
  String $mode    = '0755'      # permissions on mount point
) {
  # create the filesystem
  lvm::volume {$lv:
    ensure => 'present',
    vg     => $vg,
    pv     => $pv,
    fstype => $fs_type,
    size   => $size,
  }

  # create the mount point (mnt)
  if ($managed) {
    file {$mnt:
      ensure => 'directory',
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }
    mount {$lv:
      ensure  => 'mounted',
      name    => $mnt,
      device  => "/dev/${vg}/${lv}",
      dump    => '1',
      fstype  => $fs_type,
      options => 'defaults',
      pass    => '2',
      target  => '/etc/fstab',
      require => [Lvm::Volume[$lv],File[$mnt]],
    }
  } else {
    mount {$lv:
      ensure  => 'mounted',
      name    => $mnt,
      device  => "/dev/${vg}/${lv}",
      dump    => '1',
      fstype  => $fs_type,
      options => 'defaults',
      pass    => '2',
      target  => '/etc/fstab',
      require => Lvm::Volume[$lv],
    }
  }
}

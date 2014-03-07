define example::fs
(
  $mnt     = "$title",   # where to mount the filesystem
  $vg      = 'VolGroup', # which volume group
  $pv,                   # which physical volume
  $lv,                   # which logical volume
  $fs_type = 'ext4',     # the filesystem type
  $size,                 # how big
  $managed = true,       # do we create the file resource or not.
  $owner   = '0',        # who owns the mount point
  $group   = '0',        # which group owns the mount point
  $mode    = '0755'      # permissions on mount point
) {
  # create the filesystem
  lvm::volume {"$lv":
    ensure => 'present',
    vg     => "$vg",
    pv     => "$pv",
    fstype => "$fs_type",
    size   => "$size",
  }

  # create the mount point (mnt)
  if ($managed) {
    file {"$mnt":
      ensure => 'directory',
      owner  => "$owner",
      group  => "$group",
      mode   => "$mode",
    }
    mount {"$lv":
      name    => "$mnt",
      ensure  => 'mounted',
      device  => "/dev/$vg/$lv",
      dump    => '1',
      fstype  => "$fs_type",
      options => "defaults",
      pass    => '2',
      target  => '/etc/fstab',
      require => [Lvm::Volume["$lv"],File["$mnt"]],
    }
  } else {
    mount {"$lv":
      name    => "$mnt",
      ensure  => 'mounted',
      device  => "/dev/$vg/$lv",
      dump    => '1',
      fstype  => "$fs_type",
      options => "defaults",
      pass    => '2',
      target  => '/etc/fstab',
      require => Lvm::Volume["$lv"],
    }
  }
}

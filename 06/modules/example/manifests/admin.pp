define example::admin
(
  $user = $title,
  $ensure = 'present',
  $uid,
  $home = "/var/home/$title",
  $mode = '0750',
  $shell = "/bin/bash",
  $bashrc = undef,
  $bash_profile = undef,
  $groups = ['wheel','bin'],
  $comment = "$title Admin User",
  $expiry = 'absent',
  $forcelocal = true,
  $key,
  $keytype = 'ssh-rsa',
)
{
  include example::admin::group
  user { "$user":
    ensure     => $ensure,
    allowdupe  => 'true',
    comment    => "$comment",
    expiry     => "$expiry",
    forcelocal => $forcelocal,
    groups     => $groups,
    home       => "$home",
    shell      => "$shell",
    uid        => $uid,
    gid        => 'admin',
    require    => Group['admin']
  }
  
  # ensure the home directory location exists
  $grouprequire = Group['admin']
  $dirhome = dirname($home)
  #  notify {"user is $user": }
  case $dirhome {
    '/var/home': {
      include example::admin::varhome
      $homerequire = [$grouprequire,File['/var/home']]
    }
    '/home': {
      # do nothing, included by lsb
      $homerequire = $grouprequire
    }
    default: {
      # rely on definition elsewhere
      $homerequire = [$grouprequire,File[$dirhome]]
    }
  }
  file {"$home":
    ensure  => 'directory',
    owner   => "$uid",
    group   => 'admin',
    mode    => "$mode",
    require => $homerequire
  }

  # ensure the .ssh directory exists
  file {"$home/.ssh":
    ensure  => 'directory',
    owner   => "$uid",
    group   => 'admin',
    mode    => "0700",
    require => File["$home"]
  } 
  ssh_authorized_key { "$user-admin":
    user   => "$user",
    ensure => present,
    type   => "$keytype",
    key    => "$key",
    require => [User[$user],File["$home/.ssh"]]
  }

  # build up the bashrc from a concat
  concat { "$home/.bashrc":
    owner => $uid,
    group => $gid,
  } 
  concat::fragment { "bashrc_header_$user":
    target => "$home/.bashrc",
    source => '/etc/skel/.bashrc',
    order  => '01',
  }
  if $bashrc != undef {
    concat::fragment { "bashrc_user_$user":
      target  => "$home/.bashrc",
      content => $bashrc,
      order   => '10',
    }
  }

  #build up the bash_profile from a concat as well
  concat { "$home/.bash_profile":
    owner => $uid,
    group => $gid,
  }
  concat::fragment { "bash_profile_header_$user":
    target => "$home/.bash_profile",
    source => '/etc/skel/.bash_profile',
    order  => '01',
  }
  if $bash_profile != undef {
    concat::fragment { "bash_profile_user_$user":
      target  => "$home/.bash_profile",
      content => $bash_profile,
      order   => '10',
    }
  }

}

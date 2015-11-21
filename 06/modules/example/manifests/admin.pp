define example::admin
(
  Integer $uid,
  $key,
  String $user = $title,
  Enum['present','absent'] $ensure = 'present',
  String $home = "/var/home/${title}",
  String $mode = '0750',
  Enum['/bin/bash','/bin/ksh'] $shell = '/bin/bash',
  String $bashrc = '',
  String $bash_profile = '',
  Array[String] $groups = ['wheel','bin'],
  String $comment = "${title} Admin User",
  String $expiry = 'absent',
  $forcelocal = true,
  $keytype = 'ssh-rsa',
) {
  include example::admin::group
  user { $user:
    ensure     => $ensure,
    allowdupe  => true,
    comment    => $comment,
    expiry     => $expiry,
    forcelocal => $forcelocal,
    groups     => $groups,
    home       => $home,
    shell      => $shell,
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
  file {$home:
    ensure  => 'directory',
    owner   => $uid,
    group   => 'admin',
    mode    => $mode,
    require => $homerequire
  }

  # ensure the .ssh directory exists
  file {"${home}/.ssh":
    ensure  => 'directory',
    owner   => $uid,
    group   => 'admin',
    mode    => '0700',
    require => File[$home]
  }
  ssh_authorized_key { "${user}-admin":
    ensure  => present,
    user    => $user,
    type    => $keytype,
    key     => $key,
    require => [User[$user],File["${home}/.ssh"]]
  }

  # build up the bashrc from a concat
  concat { "${home}/.bashrc":
    owner => $uid,
    group => 1001,
  }
  concat::fragment { "bashrc_header_${user}":
    target => "${home}/.bashrc",
    source => '/etc/skel/.bashrc',
    order  => '01',
  }
  if $bashrc != '' {
    concat::fragment { "bashrc_user_${user}":
      target  => "${home}/.bashrc",
      content => $bashrc,
      order   => '10',
    }
  }

  #build up the bash_profile from a concat as well
  concat { "${home}/.bash_profile":
    owner => $uid,
    group => 1001,
  }
  concat::fragment { "bash_profile_header_${user}":
    target => "${home}/.bash_profile",
    source => '/etc/skel/.bash_profile',
    order  => '01',
  }
  if $bash_profile != '' {
    concat::fragment { "bash_profile_user_${user}":
      target  => "${home}/.bash_profile",
      content => $bash_profile,
      order   => '10',
    }
  }

}

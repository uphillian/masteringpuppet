class issue_local {
  include issue
  file {'issue_local':
    path => '/etc/issue.local',
    ensure => 'file',
  }	
  concat::fragment {'issue_local':
    target  => 'issue',
    source => '/etc/issue.local',
    order   => '99',
    require => File['issue_local'],
  }
}

class issue {
  concat { 'issue':
    path   => '/etc/issue',
  }
  concat::fragment {'issue_top':
    target  => 'issue',
    content => "Example.com\n",
    order   => '01',
  }
}

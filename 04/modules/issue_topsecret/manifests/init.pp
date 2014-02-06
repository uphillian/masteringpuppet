class issue_topsecret {
  include issue
  concat::fragment {'issue_topsecret':
    target  => 'issue',
    content => "You should forget you even know about this system.\n",
    order   => '15',
  }
}

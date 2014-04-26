class issue_confidential {
  include issue
  concat::fragment {'issue_confidential':
    target  => 'issue',
    content => "Unauthorised access to this machine is strictly prohibited. Use of this system is limited to authorised parties only.\n",
    order   => '05',
  }
}

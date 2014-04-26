class issue_secret {
  include issue
  concat::fragment {'issue_secret':
    target  => 'issue',
    content => "All information contained on this system is protected, no information may be removed from the system unless authorized.\n",
    order   => '10',
  }
}

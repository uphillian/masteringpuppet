class pdb {
  # puppetdb class
  class { 'puppetdb::server': }
  class { 'puppetdb::database::postgresql': listen_addresses => '*' }
  firewall {'5432 postgresql':
    action => 'accept',
    proto  => 'tcp',
    dport  => '5432',
  }
  firewall {'8081 puppetdb':
    action => 'accept',
    proto  => 'tcp',
    dport  => '8081',
  }
}

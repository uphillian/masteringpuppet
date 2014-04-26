class worker {
  class {'puppetdb::master::config':
    puppetdb_server     => 'puppetdb_manual.example.com',
    puppet_service_name => 'httpd',
  } 
}

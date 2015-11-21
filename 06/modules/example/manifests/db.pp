class example::db (String $db) {
  case $db {
    'mysql': {
      $dbpackage = 'mysql-server'
      $dbservice = 'mysqld'
    }
    'postgresql': {
      $dbpackage = 'postgresql-server'
      $dbservice = 'postgresql'
    }
    default: {
      notify{ 'Unknown DB type': }
    }
  }
  package { $dbpackage: }
  service { $dbservice:
    ensure  => true,
    enable  => true,
    require => Package[$dbpackage]
  }
}

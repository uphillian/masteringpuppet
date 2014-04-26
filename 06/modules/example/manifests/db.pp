class example::db ($db) {
  case $db {
    'mysql': {
      $dbpackage = 'mysql-server'
      $dbservice = 'mysqld'
    }
    'postgresql': {
      $dbpackage = 'postgresql-server'
      $dbservice = 'postgresql'
    }
  }
  package { "$dbpackage": }
  service { "$dbservice": 
    ensure  => true,
    enable => true,
    require => Package["$dbpackage"]
  }
}

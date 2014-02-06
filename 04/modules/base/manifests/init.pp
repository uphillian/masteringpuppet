class base {
  $welcome = hiera('welcome','Unwelcome')
  file {'/etc/motd':
    mode => '0644',
    owner => '0',
    group => '0',
    content => inline_template("PRODUCTION\n<%= welcome %>\nManaged Node: <%= hostname %>\nManaged by Puppet version <%= puppetversion %>\n"),
  }

  ini_setting{'puppet_pluginsync_on':
    path    => '/etc/puppet/puppet.conf',
    section => 'main',
    setting => 'pluginsync',
    value   => true,
  }
}


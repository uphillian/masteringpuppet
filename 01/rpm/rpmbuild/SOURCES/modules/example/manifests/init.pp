class example {
	notify {"This is an example.": }
	file {'/tmp/example':
		mode => '0644',
		owner => '0',
		group => '0',
		content => 'This is also an example.'
	}
	cron { 'example.com-puppet':
	  ensure  => 'present',
	  command => '/bin/env puppet apply --logdest syslog --modulepath=/var/local/puppet/modules /var/local/puppet/manifests/site.pp',
	  minute  => ['*/30'],
	  target  => 'root',
	  user    => 'root',
	}
}

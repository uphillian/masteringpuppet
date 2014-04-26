class example {
	notify {"This is an example.": }
	file {'/tmp/example':
		mode => '0644',
		owner => '0',
		group => '0',
		content => 'This is also an example.'
	}
}

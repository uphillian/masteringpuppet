$0 = "master"

# if you want debugging:
# ARGV << "--debug"

ARGV << "--rack"
ARGV << "--confdir" << "/etc/puppet"
ARGV << "--vardir"  << "/var/lib/puppet"

require 'puppet/util/command_line'
run Puppet::Util::CommandLine.new.execute

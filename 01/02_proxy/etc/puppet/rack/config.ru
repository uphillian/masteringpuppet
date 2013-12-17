$0 = "master"

# if you want debugging:
#ARGV << "--debug"

ARGV << "--rack"
ARGV << "--confdir" << "/etc/puppet"
ARGV << "--vardir"  << "/var/lib/puppet"
#ARGV << "--ssl_client_header=X-Client-DN"
#ARGV << "--ssl_client_verify_header=X-Client-Verify"

require 'puppet/util/command_line'
run Puppet::Util::CommandLine.new.execute

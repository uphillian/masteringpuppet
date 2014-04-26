# reverse.rb
# Set a fact for the reverse lookup of the network on eth0

require 'ipaddr'
require 'puppet/util/ipcidr'

# define 2 facts for each interface passed in
def reverse(dev)
  # network of device
  ip = IPAddr.new(Facter.value("network_#{dev}"))
  # network in cidr notation (uuu.vvv.www.xxx/yy)
  nm = Puppet::Util::IPCidr.new(Facter.value("network_#{dev}")).mask(Facter.value("netmask_#{dev}"))
  cidr = nm.cidr

  # set fact for network in reverse vvv.www.uuu.in-addr.arpa
  Facter.add("reverse_#{dev}") do
    setcode do ip.reverse.to_s[2..-1] end
  end
  
  # set fact for network in cidr notation
  Facter.add("network_cidr_#{dev}") do
    # 
    setcode do cidr end
  end
end

# loop through the interfaces, defining the two facts for each
interfaces = Facter.value('interfaces').split(',')
interfaces.each do
  |eth| reverse(eth)
end

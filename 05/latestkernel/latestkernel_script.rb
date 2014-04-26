#!/usr/bin/env ruby
#
require 'puppet'
require 'facter'

def sanitize_version (version)
 temp = version.gsub(/.(el5|el6|fc19|fc20)/,'')
 return temp.gsub(/.(x86_64|i686|i586|i386)/,'')
end

kernels = %x( rpm -q kernel --qf '%{version}-%{release}\n' )
# drop alpha numberic endings

kernels = sanitize_version(kernels)

latest = ''
for kernel in kernels do
  kernel=kernel.chomp()
  if latest == ''
    latest = kernel
  end
  #print "%s > %s = %s\n" % [kernel,latest,Puppet::Util::Package.versioncmp(kernel,latest)]
  if Puppet::Util::Package.versioncmp(kernel,latest) > 0
	latest = kernel
  end
end
kernelrelease = Facter.value('kernelrelease')
kernelrelease = sanitize_version(kernelrelease)
if Puppet::Util::Package.versioncmp(kernelrelease,latest) == 0
  kernellatest = 1
else
  kernellatest = 0
end

print "running kernel = %s\n" % kernelrelease
print "latest installed kernel = %s\n" % latest
print "kernellatest = %s\n" % kernellatest

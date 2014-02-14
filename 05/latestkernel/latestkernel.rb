# drop alpha numberic endings
def sanitize_version (version)
 temp = version.gsub(/.(el5|el6|fc19|fc20)/,'')
 return temp.gsub(/.(x86_64|i686|i586|i386)/,'')
end

kernels = %x( rpm -q kernel --qf '%{version}-%{release}\n' )
kernels = sanitize_version(kernels)

latest = ''
for kernel in kernels do
  kernel=kernel.chomp()
  if latest == ''
    latest = kernel
  end
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

Facter.add("example_latestkernel") do
  setcode do kernellatest end
end
Facter.add("example_latestkernelinstalled") do
  setcode do latest end
end

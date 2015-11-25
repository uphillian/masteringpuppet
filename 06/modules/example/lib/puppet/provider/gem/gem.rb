require 'open3'
Puppet::Type.type(:gem).provide :gem do
  desc "Manages gems using gem"
  def self.instances
    gems = []
    command = 'gem list -l'
    begin
      stdin, stdout, stderr = Open3.popen3(command)
      for line in stdout.readlines
        (name,version) = line.split(' ')
        gem = {}
        gem[:provider] = self.name 
        gem[:name] = name
        gem[:ensure] = :present
        gem[:version] = version.tr('()','')
        gems << new(gem)
      end
    rescue 
      raise Puppet::Error, "Failed to list gems using '#{command}'"
    end
    gems
  end
  def exists?
    @property_hash[:ensure] == :present
  end

  def version
    @property_hash[:version] || :absent
  end

  def self.prefetch(resources)
    gems = instances
    resources.keys.each do |name|
      if provider = gems.find{ |gem| gem.name == name }
        resources[name].provider = provider
      end
    end
  end

  def create
    g = @resource[:version] ? [@resource[:name], '--version', @resource[:version]] : @resource[:name]
    command = "gem install #{g} -q"
    begin
      system command
      @property_hash[:ensure] = :present
    rescue
      raise Puppet::Error, "Failed to install #{@resource[:name]} '#{command}'"
    end
  end

  def destroy
    g = @resource[:version] ? [@resource[:name], '--version', @resource[:version]] : @resource[:name]
    command = "gem uninstall #{g} -q -x"
    begin
      system command
    rescue
      raise Puppet::Error, "Failed to remove #{@resource[:name]} '#{command}'"
    end
    @property_hash.clear
  end
end

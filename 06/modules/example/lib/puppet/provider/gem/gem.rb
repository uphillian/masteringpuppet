Puppet::Type.type(:gem).provide(:gem) do
  commands :gem => "gem"
  def exists?
          begin
                  gem= resource[:version] ? "%{resource[:name]} --version #{resource[:version]}" | resource[:name]
                  gem('list', '-i', gem)
          rescue Puppet::ExecutionFailure => e
                  false
          end
  end
  def create
          gem= resource[:version] ? "%{resource[:name]} --version #{resource[:version]}" | resource[:name]
          gem('install', gem)
  end
  def destroy
          gem= resource[:version] ? "%{resource[:name]} --version #{resource[:version]}" | resource[:name]
          gem('uninstall', gem, '-q', '-x')
  end
end

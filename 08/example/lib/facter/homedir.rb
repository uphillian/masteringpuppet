Facter.add(:homedir) do
  if Process.uid != 0 and ENV['HOME'] != nil
          setcode do
            begin
              ENV['HOME']
            rescue LoadError
              nil
            end
          end
  end
end


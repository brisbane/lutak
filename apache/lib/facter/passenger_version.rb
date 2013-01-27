def get_redhat_passenger_version
  version = Facter::Util::Resolution.exec('yum info mod_passenger |grep "^Version"')
  if match = /^Version\s*:\s*(\d+\.\d+\.\d+).*$/.match(version)
    match[1]
  else
    nil
  end
end

Facter.add("passenger_version") do
  setcode do
    case Facter.value('osfamily')
      when 'RedHat'
        get_redhat_passenger_version()
      else
        nil
    end
  end
end

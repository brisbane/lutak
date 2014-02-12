def get_redhat_passenger_version
  version = Facter::Util::Resolution.exec('/bin/rpm -qa mod_passenger')
  if match = /^mod_passenger-(\d+\.\d+\.\d+)-\d+.*$/.match(version)
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

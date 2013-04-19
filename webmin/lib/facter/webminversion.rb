def get_debian_webmin_version
  depends = Facter::Util::Resolution.exec('apt-cache show webmin |grep "^Depends" |head -n 1')
  if match = /^Depends: webmin-(.*)$/.match(depends)
    match[1]
  else
    nil
  end
end

def get_redhat_webmin_version
  version = Facter::Util::Resolution.exec('/bin/rpm -qa webmin')
  if match = /^webmin-(\d+\.\d+)/.match(version)
    match[1]
  else
    nil
  end
end

Facter.add("webminversion") do
  setcode do
    case Facter.value('osfamily')
      when 'RedHat'
        get_redhat_webmin_version()
      when 'Debian'
        get_debian_webmin_version()
      else
        nil
    end
  end
end

Puppet::Type.newtype(:cobblerprofile) do
@doc = "Manages the Cobbler profiles

A typical rule will look like this:

cobblerprofile {'CentOS-6.3-x86_64':
  ensure        => present,
  distro        => 'CentOS-6.3-x86_64',
}"
 
  desc "The cobbler profile type"

  ensurable

  newparam(:name) do
    isnamevar
    desc "The name of the profile, will be seen in cobbler profile list"
  end

  newproperty(:distro) do
    desc "Distribution this profile"
  end
  autorequire(:cobblerdistro) do
    self[:distro]
  end

  newproperty(:kickstart) do
    desc "kickstart file for profile"
  end
  autorequire(:file) do
    self[:kickstart]
  end

  newproperty(:nameservers, :array_matching => :all) do
    desc "list of nameservers"
    defaultto []
    # http://projects.puppetlabs.com/issues/10237
    def insync?(is)
      return false unless is == should
      true
    end
  end

  newproperty(:repos, :array_matching => :all) do
    desc "list of repositories added to profile"
    defaultto []
    # http://projects.puppetlabs.com/issues/10237
    def insync?(is)
      return false unless is == should
      true
    end

  end
  autorequire(:cobblerrepo) do
    self[:repos]
  end

end

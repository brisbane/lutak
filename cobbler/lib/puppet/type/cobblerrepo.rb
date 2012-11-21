Puppet::Type.newtype(:cobblerrepo) do
@doc = "Manages the Cobbler repositories

A typical rule will look like this:

cobblerrepo {'PuppetLabs-5-x86_64-deps':
  ensure        => present,
  arch          => 'x86_64',
  priority      => 99,
  mirror        => 'http://yum.puppetlabs.com/el/5/dependencies/x86_64',
  mirrorlocally => true,
}

This rule would ensure that the kernel swappiness setting be set to '20'"
 
  desc "The cobbler repo type"

  ensurable

  newparam(:name) do
    isnamevar
    desc "The name of the repo, will be seen in cobbler repo list"
  end

  newparam(:arch) do
    desc "The architecture of repository (x86_64 or i386)."
    newvalues(:x86_64, :i386)
    munge do |value| # fix values
      case value
      when :amd64
        :x86_64
      when :i86pc
        :i386
      else
        super
      end
    end
  end

  newparam(:priority) do
    desc "Priority of the repository"
    validate do |value|
       unless Integer(value) >= 0 or Integer(value) <= 99
         raise ArgumentError, "%s only accepts values between 0 and 99." % value
       end
    end
  end

  newparam(:mirror) do
    desc "The link of the repo"
    validate do |value|
      unless value =~ /^http(s)?:/
        raise ArgumentError, "%s is not a valid link to online repository." % value
      end
    end
  end

  newparam(:mirrorlocally) do
    desc "Keep local mirror or not."
    newvalues(:true, :false)
  end

end

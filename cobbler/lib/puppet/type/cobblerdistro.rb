Puppet::Type.newtype(:cobblerdistro) do
@doc = "Manages the Cobbler distros.

A typical rule will look like this:

cobblerdistro {'CentOS-6.3-x86_64':
  ensure  => present,
  arch    => 'x86_64',
  isolink => 'http://mi.mirror.garr.it/mirrors/CentOS/6.3/isos/x86_64/CentOS-6.3-x86_64-bin-DVD1.iso',
  destdir => '/distro',
}

This rule would ensure that the kernel swappiness setting be set to '20'"
 
  desc "The cobbler distro type"

  ensurable

  newparam(:name) do
    isnamevar
    desc "The name of the distro, that will create subdir in $distro"
  end

  newparam(:arch) do
    desc "The architecture of distro (x86_64 or i386)."
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

  newparam(:isolink) do
    desc "The link of the distro ISO image."
    validate do |value|
      unless value =~ /^http:.*iso/
        raise ArgumentError, "%s is not a valid link to ISO image." % value
      end
    end
  end

  newparam(:destdir) do
    desc "The link of the distro ISO image."
    validate do |value|
        if(value == nil)
            raise ArgumentError, "Directory must be specified"
        end
    end
  end
end

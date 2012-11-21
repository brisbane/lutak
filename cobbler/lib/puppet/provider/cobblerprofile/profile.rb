Puppet::Type.type(:cobblerprofile).provide(:profile) do
    desc "Support for managing the Cobbler profiles"

    commands :cobbler => '/usr/bin/cobbler'
   
    # gets & sets distribution (distro)
    def distro
        return cobbler('profile', 'report', '--name=' + @resource[:name]).grep(/^Distribution/).to_s.sub(/^Distribution.*: /,'').chomp
    end
    def distro=(value)
        cobbler('profile', 'edit', '--name=' + @resource[:name], '--profile=' + value)
    end

    # gets & sets kickstart
    def kickstart
        return cobbler('profile', 'report', '--name=' + @resource[:name]).grep(/^Kickstart  /).to_s.sub(/^Kickstart.*: /,'').chomp
    end
    def kickstart=(value)
        cobbler('profile', 'edit', '--name=' + @resource[:name], '--kickstart=' + value)
    end

    # gets & sets nameservers
    def nameservers
        # get current system settings
        return cobbler('profile', 'report', '--name=' + @resource[:name]).grep(/^Name Servers  /).to_s.sub(/^Name Servers.*: /,'').chomp.gsub(/[\[\]' ]/,'').split(",")
    end
    def nameservers=(value)
        # create cobblerargs variable
        cobblerargs="profile edit --name=" + @resource[:name]
	# turn string into array
	cobblerargs = cobblerargs.split(' ')
        # set up nameserver argument 
        cobblerargs << ("--name-servers=" + value * " ")
        # finally set value
        cobbler(cobblerargs)
    end

    # gets & sets repos
    def repos
        # get current system settings
        return cobbler('profile', 'report', '--name=' + @resource[:name]).grep(/^Repos/).to_s.sub(/^Repos.*: /,'').chomp.gsub(/[\[\]' ]/,'').split(",")
    end
    def repos=(value)
        # create cobblerargs variable
        cobblerargs="profile edit --name=" + @resource[:name]
	# turn string into array
	cobblerargs = cobblerargs.split(' ')
        # set up nameserver argument 
        reposarg="--repos=" + value * " "
        cobblerargs << ("--repos=" + value * " ")
        # finally set value
        cobbler(cobblerargs)
    end

    def create
	# check profile name
        if @resource[:distro].nil? 
            raise ArgumentError, "you must choose distribution for profile"
        end
	# create cobblerargs variable
	cobblerargs="profile add --name=" + @resource[:name] + " --distro=" + @resource[:distro]
	
	# turn string into array
	cobblerargs = cobblerargs.split(' ')

	# check repos
	unless @resource[:repos].nil?
            if @resource[:repos].kind_of?(Array)
                tmparg="--repos=" + @resource[:repos] * " "
            elsif @resource[:repos].kind_of?(String)
                tmparg="--repos=" + @resource[:repos]
            end
	else
            tmparg='--repos=""'
        end
        cobblerargs << tmparg

	# run cobbler commands
	cobbler(cobblerargs)

        # add distro, kickstart, nameservers & repos
        self.distro      = @resource.should(:distro)      unless self.distro      == @resource.should(:distro)
        self.kickstart   = @resource.should(:kickstart)   unless self.kickstart   == @resource.should(:kickstart)
        self.nameservers = @resource.should(:nameservers) unless self.nameservers == @resource.should(:nameservers)
        self.repos       = @resource.should(:repos)       unless self.repos       == @resource.should(:repos)

        # final sync
	cobbler("sync")
    end

    def destroy
	# remove repository from cobbler
	cobbler("profile","remove","--name="+@resource[:name])
	cobbler("sync")
    end

    def exists?
        # check if cobbler has current distro added
	return false if cobbler("profile","list").grep(/#{Regexp.escape(@resource[:name])}/).empty?
        return true
    end
end

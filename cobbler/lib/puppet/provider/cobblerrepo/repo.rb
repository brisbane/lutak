Puppet::Type.type(:cobblerrepo).provide(:repo) do
    desc "Support for managing the Cobbler repos"

    commands :cobbler => 'cobbler'

    def create
	# sanity check
        if @resource[:mirror].nil? 
            raise ArgumentError, "mirror of the repository must be specified!"
        end

        # add or edit?
        addoredit="edit"
        if cobbler("repo","list").grep(/#{Regexp.escape(@resource[:name])}/).empty?
            addoredit="add"
        end

        # create cobblerargs variable
        cobblerargs = "repo " + addoredit + " --name=" + @resource[:name] 
        cobblerargs += " --arch=" + @resource[:arch].to_s
        cobblerargs += " --mirror=" + @resource[:mirror]
        tmparg = "--mirror-locally=no"
	unless @resource[:mirrorlocally].nil?
	  if @resource[:mirrorlocally].to_s.grep(/false/i).empty?
            tmparg = "--mirror-locally=yes"
	  end
	end

        # turn string into array
        cobblerargs = cobblerargs.split(' ')
        cobblerargs << tmparg

	# run cobbler commands
	cobbler(cobblerargs)
	cobbler("reposync")
	cobbler("sync")
    end

    def destroy
	# remove repository from cobbler
	reponame="--name=" + @resource[:name]
	cobbler("repo","remove",reponame)
	cobbler("reposync")
	cobbler("sync")
    end
  
    def exists?
	# sanity check
        if @resource[:mirror].nil? 
            raise ArgumentError, "mirror of the repository must be specified!"
        end

        # check if cobbler has current repo added
	if cobbler("repo","list").grep(/#{Regexp.escape(@resource[:name])}/).empty?
            return false
        else
            namearg="--name=" + @resource[:name]
            # check mirror
            if cobbler("repo","report",namearg).grep(/#{Regexp.escape(@resource[:mirror])}/).empty?
                return false
            end
            # check the priority
            unless @resource[:priority].nil?
                if cobbler("repo","report",namearg).grep(/#{Regexp.escape(@resource[:priority])}/).grep(/Priority/).empty?
                    return false
                end
            end
            # check the arch
            unless @resource[:arch].nil?
                if cobbler("repo","report",namearg).grep(/#{@resource[:arch]}/).grep(/Arch/).empty?
                    return false
                end
            end
            # check the mirrorlocally
            unless @resource[:mirrorlocally].nil?
                cur = cobbler("repo","report",namearg).grep(/Mirror locally/).to_s.sub(/^.* : /, '')
                new = @resource[:mirrorlocally].to_s
                if cur.grep(/#{new}/i).empty?
                    return false
                end
            end
	end
	return true
    end
end

# include XML/RPC client library
require 'xmlrpc/client'

# start provider code
Puppet::Type.type(:cobblersystem).provide(:system) do
    desc "Support for managing the Cobbler systems"

    commands :cobbler => '/usr/bin/cobbler'


    # gets & sets profile
    def profile
	return cobbler('system', 'report', '--name=' + @resource[:name]).grep(/^Profile/).to_s.sub(/^Profile.*: /,'').chomp
    end
    def profile=(value)
	cobbler('system', 'edit', '--name=' + @resource[:name], '--profile=' + value)
    end

    # gets & sets hostname
    def hostname
	return cobbler('system', 'report', '--name=' + @resource[:name]).grep(/^Hostname/).to_s.sub(/^Hostname.*: /,'').chomp
    end
    def hostname=(value)
        cobbler('system', 'edit', '--name=' + @resource[:name], '--hostname=' + value)
    end

    # gets & sets gateway
    def gateway
	return cobbler('system', 'report', '--name=' + @resource[:name]).grep(/^Gateway/).to_s.sub(/^Gateway.*: /,'').chomp
    end
    def gateway=(value)
        cobbler('system', 'edit', '--name=' + @resource[:name], '--gateway=' + value)
    end

    # gets & sets netboot
    def netboot
	if cobbler('system', 'report', '--name=' + @resource[:name]).grep(/^Netboot Enabled/).grep(/false/i).empty?
            return :true
	else
            return :false
	end
    end
    def netboot=(value)
        tmparg="--netboot-enabled=0"
        if value.to_s.grep(/false/i).empty?
            tmparg="--netboot-enabled=1"
        end
        cobbler('system', 'edit', '--name=' + @resource[:name], tmparg)
    end

    # gets & sets interfaces
    def interfaces
        # name argument for cobbler
        namearg="--name=" + @resource[:name]
        # available settings
        settings = [ 'mac_address',		# mac_address
                     'interface_type',		# interface_type
                     'interface_master',	# interface_master
                     'static',			# static
                     'ip_address',		# ip_address
                     'netmask',			# netmask
                     'bonding_opts',		# bonding_opts
                     'static_routes',		# static routes
                     'management',		# buildiso inst
                     'dns_name',                # dns name, cobbler generates file from this info
                   ]

        result = {}
        currentsystem = {}

        # connect to cobbler server on localhost
        cobblerserver = XMLRPC::Client.new2("http://127.0.0.1/cobbler_api")
        # make the query (get all systems)
        xmlrpcresult = cobblerserver.call("get_systems")
        # get properties of current system to variable
        xmlrpcresult.each do |member|
            currentsystem = member unless member['name'] != @resource[:name]
        end

        # if system has no interfaces, return empty hash
        return result if currentsystem['interfaces'] == {}

        # check settings
        currentsystem['interfaces'].each do |iface_name,iface_settings|
            result["#{iface_name}"] = {}
            settings.each do |setting|
                # get correct specific setting
                case setting
                when 'static'
                    if iface_settings["#{setting}"] or iface_settings["#{setting}"] == 'True' then
                        iface_settings["#{setting}"] = '1'
                    else
                        iface_settings["#{setting}"] = '0'
                    end
                when 'static_routes'
                    iface_settings["#{setting}"] = iface_settings["#{setting}"] * " "
                end
                result["#{iface_name}"]["#{setting}"] = iface_settings["#{setting}"]
            end 
        end
        result
    end

    def interfaces=(value) 
        # name argument for cobbler
        namearg="--name=" + @resource[:name]
        # available settings
        settings = [ 'mac_address',		# mac_address
                     'interface_type',		# interface_type
                     'interface_master',	# interface_master
                     'static',			# static
                     'ip_address',		# ip_address
                     'netmask',			# netmask
                     'bonding_opts',		# bonding_opts
                     'static_routes',		# static routes
                     'management',		# buildiso inst
                     'dns_name',                # dns name, cobbler generates file from this info
                   ]

        # modify interfaces according to resource in puppet
        value.each do |key, val|
            ifacearg="--interface=" + key
            settings.each do |setting|
                # correct specific settings
                case setting
                when 'interface_type'
                    setting_long = 'interface-type'
                when 'interface_master'
                    setting_long = 'interface-master'
                when 'bonding_opts'
                    setting_long = 'bonding-opts'
                when 'mac_address'
                    setting_long = 'mac-address'
                when 'ip_address'
                    setting_long = 'ip-address'
                when 'static_routes'
                    setting_long = 'static-routes'
                when 'dns_name'
                    setting_long = 'dns-name'
                else
                    setting_long = setting
                end
                # finally construct command and edit system properties
                unless val[setting].nil?
                    valuearg="--#{setting_long}=" + val[setting].to_s
                    cobbler("system","edit",namearg,ifacearg,valuearg)
                end
            end
        end

        # connect to cobbler server on localhost
        cobblerserver = XMLRPC::Client.new2("http://127.0.0.1/cobbler_api")
        # make the query (get all systems)
        xmlrpcresult = cobblerserver.call("get_systems")
        # get properties of current system to variable
        currentsystem = {}
        xmlrpcresult.each do |member|
            currentsystem = member unless member['name'] != @resource[:name]
        end
        # delete cobbler interface if it's not present in the value section
        currentsystem['interfaces'].each do |iface_name,iface_settings|
            cobbler("system", "edit", namearg, "--interface="+iface_name, "--delete-interface") unless value.has_key?(iface_name)
        end
    end

    def create
	# add system
        cobbler('system', 'add', '--name='+@resource[:name], '--profile='+@resource[:profile])

	# add hostname, gateway, interfaces, netboot
        self.hostname = @resource.should(:hostname) unless self.hostname == @resource.should(:hostname)
        self.gateway = @resource.should(:gateway) unless self.gateway == @resource.should(:gateway)
        self.interfaces = @resource.should(:interfaces) unless self.interfaces == @resource.should(:interfaces)
        self.netboot = @resource.should(:netboot) unless self.netboot == @resource.should(:netboot)
	# sync state
	cobbler('sync')
    end

    def destroy
	# remove repository from cobbler
	cobbler('system', 'remove', '--name='+@resource[:name])
	cobbler('sync')
    end

    def exists?
        # connect to cobbler server on localhost
        cobblerserver = XMLRPC::Client.new2("http://127.0.0.1/cobbler_api")
        # check if system exists
        return false if cobblerserver.call("find_system", 'name' => @resource[:name]).empty?

        # checks are ok, so return true
        return true
    end
end

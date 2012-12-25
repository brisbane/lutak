require 'xmlrpc/client'

Puppet::Type.type(:cobblersystem).provide(:system) do
  desc 'Support for managing the Cobbler systems'

  commands :cobbler => '/usr/bin/cobbler'

  mk_resource_methods

  def self.instances
    keys = []
    # connect to cobbler server on localhost
    cobblerserver = XMLRPC::Client.new2('http://127.0.0.1/cobbler_api')
    # make the query (get all systems)
    xmlrpcresult = cobblerserver.call('get_systems')

    # available network settings
    settings = [ 'mac_address',      # mac_address
                 'interface_type',   # interface_type
                 'interface_master', # interface_master
                 'static',           # static
                 'ip_address',       # ip_address
                 'netmask',          # netmask
                 'bonding_opts',     # bonding_opts
                 'static_routes',    # static routes
                 'management',       # buildiso inst
                 'dns_name',         # dns name, cobbler generates file from this info
               ]
    iface_hash = {}

    # get properties of current system to @property_hash
    xmlrpcresult.each do |member|
      # get interfaces
      member['interfaces'].each do |iface_name,iface_settings|
        iface_hash["#{iface_name}"] = {}
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
            iface_settings["#{setting}"] = iface_settings["#{setting}"] * ' '
          end
          iface_hash["#{iface_name}"]["#{setting}"] = iface_settings["#{setting}"]
        end
      end

      keys << new(
        :name           => member['name'],
        :ensure         => :present,
        :profile        => member['profile'],
        :interfaces     => iface_hash,
        :hostname       => member['hostname'],
        :gateway        => member['gateway'],
        :netboot        => member['netboot_enabled'].to_s,
        :comment        => member['comment']
      )
    end
    keys
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
  end

  # sets profile
  def profile=(value)
    cobbler('system', 'edit', '--name=' + @resource[:name], '--profile=' + value)
    @property_hash[:profile]=(value)
  end

  # sets hostname
  def hostname=(value)
    cobbler('system', 'edit', '--name=' + @resource[:name], '--hostname=' + value)
    @property_hash[:hostname]=(value)
  end

  # sets gateway
  def gateway=(value)
    cobbler('system', 'edit', '--name=' + @resource[:name], '--gateway=' + value)
    @property_hash[:gateway]=(value)
  end

  # sets netboot
  def netboot=(value)
    tmparg='--netboot-enabled=0'
    tmparg='--netboot-enabled=1' if value.to_s.grep(/false/i).empty?
    cobbler('system', 'edit', '--name=' + @resource[:name], tmparg)
    @property_hash[:netboot]=(value)
  end

  # sets interfaces
  def interfaces=(value)
    # name argument for cobbler
    namearg='--name=' + @resource[:name]

    # available network settings
    settings = [ 'mac_address',      # mac_address
                 'interface_type',   # interface_type
                 'interface_master', # interface_master
                 'static',           # static
                 'ip_address',       # ip_address
                 'netmask',          # netmask
                 'bonding_opts',     # bonding_opts
                 'static_routes',    # static routes
                 'management',       # buildiso inst
                 'dns_name',         # dns name, cobbler generates file from this info
               ]

    # modify interfaces according to resource in puppet
    value.each do |key, val|
      ifacearg='--interface=' + key
      settings.each do |setting|
        # substitute _ for -
        setting_log = setting.sub(/_/,'-')
        # finally construct command and edit system properties
        unless val[setting].nil?
          valuearg="--#{setting_long}=" + val[setting].to_s
          cobbler('system','edit',namearg,ifacearg,valuearg)
        end
      end
    end

    # connect to cobbler server on localhost
    cobblerserver = XMLRPC::Client.new2('http://127.0.0.1/cobbler_api')
    # make the query (get all systems)
    xmlrpcresult = cobblerserver.call('get_systems')
    # get properties of current system to variable
    currentsystem = {}
    xmlrpcresult.each do |member|
      currentsystem = member unless member['name'] != @resource[:name]
    end
    # delete cobbler interface if it's not present in the value section
    currentsystem['interfaces'].each do |iface_name,iface_settings|
      cobbler('system', 'edit', namearg, '--interface=' + iface_name, '--delete-interface') unless value.has_key?(iface_name)
    end
    @property_hash[:interfaces]=(value)
  end

  # sets comment
  def comment=(value)
    cobbler('system', 'edit', '--name=' + @resource[:name], '--comment=' + value)
    @property_hash[:comment]=(value)
  end

  def create
    # add system
    cobbler('system', 'add', '--name=' + @resource[:name], '--profile=' + @resource[:profile])

    # add hostname, gateway, interfaces, netboot
    self.hostname   = @resource.should(:hostname)   unless self.hostname   == @resource.should(:hostname)
    self.gateway    = @resource.should(:gateway)    unless self.gateway    == @resource.should(:gateway)
    self.interfaces = @resource.should(:interfaces) unless self.interfaces == @resource.should(:interfaces)
    self.netboot    = @resource.should(:netboot)    unless self.netboot    == @resource.should(:netboot)
    self.comment    = @resource.should(:comment)    unless self.comment    == @resource.should(:comment)

    # sync state
    cobbler('sync')

    # update @property_hash
    @property_hash[:ensure] = :absent
  end

  def destroy
    # remove system from cobbler
    cobbler('system', 'remove', '--name=' + @resource[:name])
    cobbler('sync')
    # update @property_hash
    @property_hash[:ensure] = :absent
  end

  def exists?
    @property_hash[:ensure] == :present
  end
end

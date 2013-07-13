require 'rest_client'
require 'json'

Puppet::Type.type(:couchbucket).provide(:bucket) do
  desc 'Support for managing the Couchbase bucket'

  commands :couchbase_cli => '/opt/couchbase/bin/couchbase-cli'

  mk_resource_methods

  def self.instances
    buckets = []

    # per bucket parsing from REST API
    JSON.parse( RestClient.get 'http://127.0.0.1:8091/pools/default/buckets' ).each do |rest_bucket|
      current_bucket = { 
        :name         => rest_bucket['name'],
        :ensure       => :present,
        :bucketType   => rest_bucket['bucketType'],
        :authType     => rest_bucket['authType'],
        :saslPassword => rest_bucket['saslPassword'],
        :proxyPort    => rest_bucket['proxyPort'],
        :numReplicas  => rest_bucket['replicaNumber'],
        :ramQuota     => rest_bucket['quota']['ram']
      }
      buckets.push(current_bucket)
    end

    # return list of present buckets
    buckets
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
  end

#  # sets profile
#  def profile=(value)
#    cobbler('system', 'edit', '--name=' + @resource[:name], '--profile=' + value)
#    @property_hash[:profile]=(value)
#  end
#
#  def create
#    # add system
#    cobbler('system', 'add', '--name=' + @resource[:name], '--profile=' + @resource[:profile])
#
#    # add hostname, gateway, interfaces, netboot
#    self.hostname       = @resource.should(:hostname)       unless self.hostname       == @resource.should(:hostname)
#    self.gateway        = @resource.should(:gateway)        unless self.gateway        == @resource.should(:gateway)
#
#    # update @property_hash
#    @property_hash[:ensure] = :absent
#  end

  def create
    # update @property_hash
    @property_hash[:ensure] = :absent
  end

  def destroy
    # remove bucket from Couchbase
    couchbase_cli('bucket-delete', '--cluster=' +  @resource[:cluster], '--bucket=' + @resource[:name], '--user=' + @resource[:admin_user], '--password=' + @resource[:admin_password])
    # update @property_hash
    @property_hash[:ensure] = :absent
  end

  def exists?
    @property_hash[:ensure] == :present
  end
end

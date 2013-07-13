Puppet::Type.newtype(:couchbucket) do
@doc = "Manages the Couchbase bucket

A typical rule will look like this:

couchbucket { 'example':
  ensure         => present,
  admin_user     => 'Administrator',
  admin_password => 'Secret',
  cluster        => '127.0.0.1:8091',
  bucketType     => memcached,
  authtype       => '',
  saslPassword   => '',
  proxyPort      => '',
  numReplicas    => '1',
  ramQuota       => '64',
}

"
  desc 'The Couchbase bucket'

  ensurable

  newparam(:name) do
    desc 'The name of the bucket.'
    isnamevar
  end

  newparam(:admin_user) do
    desc 'Administrator username for managing Couchbase.'
    defaultto 'Administrator'
  end

  newparam(:admin_password) do
    desc 'Administrator password for managing Couchbase.'
  end

  newparam (:cluster) do
    desc 'Cluster IP address (and port): <IP>(:<PORT>).'
    defaultto '127.0.0.1:8091'
    validate do |value|
      unless value.chomp.empty?
        raise ArgumentError, "%s is not a valid IP address." % value unless value =~ /\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}/
      end
    end
  end

  newproperty(:bucketType) do
    desc 'Type of the bucket, so far ony Memcached and Couchbase are supported.'
    newvalues(:memcached, :couchbase)
    defaultto :memcached
  end

  newproperty(:authtype) do
    desc 'Type of authorization. sasl is a requirement if memcached bucket is on port 11211.'
    newvalues(:sasl)
    defaultto ''
  end

  newproperty(:saslPassword) do
    desc 'Password for the sasl authentication.'
    defaultto ''
  end

  newproperty(:proxyPort) do
    desc 'Dedicated port (supports ASCII protocol and is auth-less'
  end

  newproperty(:numReplicas) do
    desc 'Number of replica (backup) copies'
    defaultto '1'
  end

  newproperty(:ramQuota) do
    desc 'Per Node RAM Quota. Total RAM used by bucket is per-node-quota x nodes number.'
    defaultto '64'
  end

end

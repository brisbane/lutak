# Class: rhcs::client
#
# This module configures node to behave like
# ricci client
#
class rhcs::client (
  $ricci_clientc_dir = "/etc/puppet/private/${::fqdn}/ricci",
) {
  # defaults
  File {
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => File['/root/.ccs'],
  }

  # generate ricci client cert
  $mypath = get_module_path('rhcs')
  if ( generate("${mypath}/scripts/generate_ricci_client_cert.sh", $ricci_clientc_dir) =~ /Success/ ) {
    file { '/root/.ccs':
      ensure  => directory,
      mode    => '0700',
      require => [],
    }
    file { '/root/.ccs/cacert.config': source => 'puppet:///private/ricci/ca/cacert.config', }
    file { '/root/.ccs/privkey.pem':   source => 'puppet:///private/ricci/privkey.pem', }
    file { '/root/.ccs/cacert.pem':    source => 'puppet:///private/ricci/cacert.pem', }

    # exported resoruce, so cluster nodes can pick it up
    @@file { "/var/lib/ricci/certs/client/client_cert_${::hostname}_root":
      source  => 'puppet:///private/ricci/cacert.pem',
      require => File['/root/.ccs/cacert.pem'],
      tag     => 'ricci_client',
    }
  }
}

# Class: resolvconf
#
# Manages /etc/resolv.conf
class resolvconf (
  $nameservers = [ '8.8.8.8', '8.8.4.4' ],
  $options     = [ 'rotate', 'timeout:1'],
  $search      = ['UNSET'],
  $domain      = 'UNSET',
  $sortlist    = ['UNSET'],
) {

  # Validates domain
  if is_domain_name($domain) != true {
    fail("Domain name, ${domain}, is invalid.")
  }

  # manage resolv.conf
  file { 'resolv.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    path    => '/etc/resolv.conf',
    content => template('resolvconf/resolv.conf.erb'),
  }
}
# vi: nowrap

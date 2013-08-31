# Class: vmtools::xen
#
# Installs the Xen Tools for XenServer from
# Srce Intern repo
class vmtools::xen {
  include ::yum::repo::srce::intern
  package { [ 'xe-guest-utilities', 'xe-guest-utilities-xenstore' ]: ensure => present, }
}

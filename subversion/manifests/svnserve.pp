#
# = Class: subversion::svnserve
#
# This modules sets up svnserve daemon
#
class subversion::svnserve {
  include ::subversion

  file { '/etc/init.d/svnserve':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/subversion/svnserve-initd',
  }

  service { 'svnserve':
    ensure  => running,
    enable  => true,
    require => File['/etc/init.d/svnserve'],
  }

}

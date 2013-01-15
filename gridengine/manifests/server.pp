# Class: gridengine::server
#
# This class installs the SGE master
#
class gridengine::server inherits gridengine {
  package { 'gridengine-qmaster':
    ensure => present,
  }
  package { 'gridengine-qmon':
    ensure => present,
  }
  file { '/opt/sge/util/install_modules/inst_common.sh':
    require => Package['gridengine'],
    source  => 'puppet:///modules/gridengine/qmaster-inst_common.sh',
    owner   => root,
    group   => root,
    mode    => '0755',
  }
}

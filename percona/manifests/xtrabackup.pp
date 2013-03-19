# Class: percona::xtrabackup
#
# This module manages Percona MySQL xtrabackup
#
class percona::xtrabackup (
  $package_ensure = '2.0.5-499.rhel6',
){
  require perl::mod::time::hires

  package { 'percona-xtrabackup' :
    ensure   => $package_ensure,
    provider => 'rpm',
    source   => "http://www.percona.com/redir/downloads/XtraBackup/LATEST/RPM/rhel6/x86_64/percona-xtrabackup-${package_ensure}.x86_64.rpm",
  }
}

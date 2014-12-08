# Class: tsm::manual
#
# Used if tsm::manual set to true
#
class tsm::manual (
  $append   = undef,
  $opt      = undef,
  $inclexcl = undef,
){

  concat::fragment{ 'dsm.sys.append':
    target => $::tsm::params::file_dsm_sys,
    source => "puppet:///private/${append}",
    order  => '15',
    noop   => true,
  }

  if $opt {
    file { $opt:
      ensure => file,
      source => "puppet:///private/${opt}",
      owner  => $::tsm::params::file_owner,
      group  => $::tsm::params::file_group,
      mode   => $::tsm::params::file_mode,
    }
  }

  if $inclexcl {
    file { $inclexcl:
      ensure => file,
      source => "puppet:///private/${inclexcl}",
      owner  => $::tsm::params::file_owner,
      group  => $::tsm::params::file_group,
      mode   => $::tsm::params::file_mode,
    }
  }

}

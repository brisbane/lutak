#
# = Define: ca::trust::add
#
define ca::trust::add (
  $source,
  $ensure = file,
) {

  include ::ca::trust
  include ::ca::params

  file { "${::ca::params::cert_addon_dir}/${name}":
    ensure => $ensure,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => $source,
    notify => Exec['enable_ca_trust', 'update_ca_trust'],
  }

}

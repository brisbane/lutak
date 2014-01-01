#
# = Define: ca::trust::add
#
define ca::trust::add (
  $source,
  $ensure = file,
  $cert_addon_dir = $::ca::params::cert_addon_dir,
) {

  include ::ca::trust

  file { "${cert_addon_dir}/${name}":
    ensure => $ensure,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => $source,
    notify => 'enable_ca_trust',
  }

}

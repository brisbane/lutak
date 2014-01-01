#
# = Class: ca::trust::redhat
#
class ca::trust::redhat (
  $enable = $::ca::trust::enable,
) {

  if ( $enable ) {
    exec { 'enable_ca_trust':
      cmd         => '/usr/bin/update-ca-trust enable',
      onlyif      => '/usr/bin/update-ca-trust check 2>&1 | /bin/grep -q \'Status: DISABLED.\'',
      refreshonly => true,
    }
  } else {
    exec { 'disable_ca_trust':
      cmd    => '/usr/bin/update-ca-trust disable',
      onlyif => '/usr/bin/update-ca-trust check 2>&1 | /bin/grep -q \'Status: ENABLED.\'',
    }
  }

}

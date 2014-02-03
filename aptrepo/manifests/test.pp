#
# = Class: aptrepo::test
#
class aptrepo::test (
  $mirror  = 'http://ftp.hr.debian.org/debian/',
  $release = 'wheezy',
  $source  = false,
) {
  file { '/etc/apt/sources.list':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('aptrepo/debian/sources.list.erb'),
  }
}

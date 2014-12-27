#
# = Define: unison::sync
#
define unison::sync (
  $source,
  $destination,
  $user      = 'root',
  $group     = 'root',
  $home      = '/root',
  $ignore    = [],
  $ignorenot = [],
  $template  = 'unison/default.erb',
  $ensure    = present,
) {
  require ::unison

  $unison_dotdir = "/${home}/.unison"

  if ! defined(File[$unison_dotdir]) {
    file { $unison_dotdir :
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0755',
    }
  }

  file { "${unison_dotdir}/${title}" :
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => template($template),
    require => File[$unison_dotdir],
  }

}
# vi:nowrap

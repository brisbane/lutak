#
# = Define: postfix::postmap
#
define postfix::postmap (
  $source  = undef,
  $content = undef,
){

  file { "/etc/postfix/${title}":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => $source,
    content => $content,
    notify  => Exec['postfix_update_postmap'],
  }

  exec { 'postfix_update_postmap':
    cwd         => '/etc/postfix',
    command     => "/usr/sbin/postmap ${title}",
    refreshonly => true,
    require     => Package['postfix'],
    notify      => Service['postfix'],
  }

}

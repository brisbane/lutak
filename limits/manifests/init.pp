#
# = Define: limits
#
# Manage limits.conf settings.
#
define limits (
  $ensure   = present,
  $priority = false,
  $domain   = '*',
  $type     = 'soft',
  $item     = undef,
  $value    = undef,
  $comment  = undef,
) {

  ### Input parameters validation
  validate_string($domain)
  validate_re($type, ['soft','hard'], 'Valid values are: soft, hard')
  validate_re($item, ['core','data','fsize','memlock','nofile','rss','stack','cpu','nproc','as','maxlogins','maxsyslogins','priority','locks','sigpending','msgqueue','nice','rtprio'], 'Valid valuse are: core, data, fsize, memlock, nofile, rss, stack, cpu, nproc, as, maxlogins, maxsyslogins, priority, locks, sigpending, msgqueue, nice, rtprio')
  validate_string($comment)

  if ( $priority ) {
    $limits_title = "${priority}-${title}"
  } else {
    $limits_title = $title
  }

  # The permanent change
  file { "/etc/security/limits.d/${limits_title}.conf":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('limits/limits.confd.erb'),
  }

}

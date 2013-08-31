# Class: apache::mod::security
class apache::mod::security (
  $secruleengine              = 'DetectionOnly',
  $request_body_limit         = '13107200',
  $request_body_nofileslimit  = '131072',
  $request_body_inmemorylimit = '131072',
  $request_body_limitaction   = 'Reject',
  $pcre_match_limit           = '1000',
  $pcre_match_limitrecursion  = '1000',
  $response_body_access       = 'Off',
  $debug_log                  = '/var/log/httpd/modsec_debug.log',
  $debug_log_level            = '0',
  $audit_engine               = 'RelevantOnly',
  $audit_log_relevant_status  = '^(?:5|4(?!04))',
  $audit_log_parts            = 'ABIJDEFHZ',
  $audit_log_type             = 'Serial',
  $audit_log                  = '/var/log/httpd/modsec_audit.log',
  $argument_separator         = '&',
  $cookie_format              = '0',
  $tmp_dir                    = '/var/lib/mod_security',
  $data_dir                   = '/var/lib/mod_security',
  ) {
  include ::apache::mod::unique_id
  apache::mod { 'security2': }

  file { '/etc/httpd/conf.d/mod_security.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('apache/mod/security.conf.erb'),
    notify  => Service['httpd'],
  }

}

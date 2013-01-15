# Class: globus::jobmanager::sge::seg
#
# Installs Globus Toolkit SGE SEG Job Manager
#
class globus::jobmanager::sge::seg {
  include globus::gatekeeper
  include globus::seg

  package { 'globus-gram-job-manager-sge-setup-seg':
    ensure => present,
  }
  file { '/etc/grid-services/jobmanager-sge' :
    ensure  => link,
    target  => '/etc/grid-services/available/jobmanager-sge-seg',
    require => [ Package['globus-gram-job-manager-sge-setup-seg'] ],
    notify  => Service['globus-gatekeeper'],
  }
  file { '/etc/globus/scheduler-event-generator/sge' :
    ensure  => link,
    target  => '/etc/globus/scheduler-event-generator/available/sge',
    require => [ Package['globus-gram-job-manager-sge-setup-seg'] ],
    notify  => Service['globus-scheduler-event-generator'],
  }
}

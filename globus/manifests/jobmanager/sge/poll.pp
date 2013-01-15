# Class: globus::jobmanager::sge::poll
#
# Installs Globus Toolkit SGE Poll Job Manager
#
class globus::jobmanager::sge::poll {
  include globus::gatekeeper

  package { 'globus-gram-job-manager-sge-setup-poll':
    ensure => present,
  }
  file { '/etc/grid-services/jobmanager-sge' :
    ensure  => link,
    target  => '/etc/grid-services/available/jobmanager-sge-poll',
    require => [ Package['globus-gram-job-manager-sge-setup-poll'] ],
    notify  => Service['globus-gatekeeper']
  }
}

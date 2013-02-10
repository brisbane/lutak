# Class: htcondor
#
# Installs HTCondor
#
class htcondor {
  package {'condor':
    ensure   => latest,
  }
  file {'/etc/condor/condor_config.local':
    ensure   => file,
    owner    => root,
    group    => root,
    mode     => '0644',
    source   => 'puppet:///private/htcondor/condor_config.local',
    require  => Package['condor'],
    notify   => Service['condor'],
  }
  service {'condor':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => File['/etc/condor/condor_config.local'],
  }
}

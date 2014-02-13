# Class: mpi::mpich2
#
# Class for installation of Mpich2
#
# Parameters:
#
# Actions:
#
# Sample Usage:
#   include mpi::mpich2
#
class mpi::mpich2 {
  package {'mpich2':
    ensure  => present,
  }
  package {'mpich2-devel':
    ensure  => present,
  }
  package {'mpich2-doc':
    ensure  => present,
  }

  #file { '/etc/profile.d/mpich2.sh':
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  source  => 'puppet:///modules/mpi/mpich2.sh',
  #}
  #file { '/etc/profile.d/mpich2.csh':
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  source  => 'puppet:///modules/mpi/mpich2.csh',
  #}
}

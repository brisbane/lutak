# Class: mpi::mvapich2
#
# Class for installation of Mvapich2
#
# Parameters:
#
# Actions:
#
# Sample Usage:
#   include mpi::mvapich2
#
class mpi::mvapich2 {
  package {'mvapich2':
    ensure  => present,
  }
  package {'mvapich2-devel':
    ensure  => present,
  }
  file { '/etc/profile.d/mvapich2.sh':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/mpi/mvapich2.sh',
  }
  file { '/etc/profile.d/mvapich2.csh':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/mpi/mvapich2.csh',
  }
  file { '/etc/security/limits.d/memlock.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    source  => 'puppet:///modules/mpi/memlock.conf',
  }
}

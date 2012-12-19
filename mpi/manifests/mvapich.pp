# Class: mpi
#
# Superclass for installation of Mvapich
#
# Parameters:
#
# Actions:
#
# Sample Usage:
#   include mpi::mvapich
#
class mpi::mvapich {
  package {'mvapich':
    ensure  => present,
  }
  package {'mvapich-devel':
    ensure  => present,
  }
}

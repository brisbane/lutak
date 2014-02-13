# Class: cude
#
# Module for installing NVIDIA CUDA
#
class cuda {
  require yum::repo::elrepo

  # NVIDIA Driver from elrepo
  package { 'nvidia-x11-drv':
    ensure => present,
  }

  # CUDA toolkit
  package { 'cudatoolkit':
    ensure  => present,
    require => Package['nvidia-x11-drv'],
  }
}

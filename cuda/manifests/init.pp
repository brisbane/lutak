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

  file { '/etc/init.d/nvidia':
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    source  => 'puppet:///modules/cuda/nvidia',
  }
  service { 'nvidia':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => [ Package['nvidia-x11-drv'], File['/etc/init.d/nvidia'] ]
  }
}

# Class: cude::service
#
# Module for installing NVIDIA CUDA
#
class cuda::service {
  require yum::repo::elrepo

  # NVIDIA Driver from elrepo
  package { 'nvidia-x11-drv':
    ensure => present,
  }
  file { '/etc/init.d/nvidia':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/cuda/nvidia',
  }
  service { 'nvidia':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => [ Package['nvidia-x11-drv'], File['/etc/init.d/nvidia'] ]
  }
}

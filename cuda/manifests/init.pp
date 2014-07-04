# Class: cude
#
# Module for installing NVIDIA CUDA
#
class cuda {
  require yum::repo::cuda

  # CUDA toolkit
  package { 'cuda-extra-libs-5-5':
    ensure  => present,
  }
  package { 'cuda-core-5-5':
    ensure  => present,
  }
  file { '/etc/ld.so.conf.d/cuda-x86_64.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/cuda/cuda-x86_64.conf',
  }
  file { '/etc/profile.d/cuda.sh':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/cuda/cuda.sh',
  }
  file { '/etc/profile.d/cuda.csh':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/cuda/cuda.csh',
  }
}

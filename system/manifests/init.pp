# Class: system
class system {
  group { 'wheel':
    ensure => present,
  }
}

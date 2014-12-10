# Class: aptrepo::ubuntu
#
# This module manages Ubuntu repos
#
# Sample Usage:
#   include aptrepo::debian
#

class aptrepo::ubuntu (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'ubuntu':
    location    => 'http://hr.archive.ubuntu.com/ubuntu/',
    release     => $::lsbdistcodename,
    repos       => 'main restricted universe multiverse',
    include_src => true,
  }
  ::apt::source { 'ubuntu-updates':
    location    => 'http://hr.archive.ubuntu.com/ubuntu/',
    release     => "${::lsbdistcodename}-updates",
    repos       => 'main restricted universe multiverse',
    include_src => true,
  }
  ::apt::source { 'ubuntu-backports':
    location    => 'http://hr.archive.ubuntu.com/ubuntu/',
    release     => "${::lsbdistcodename}-backports",
    repos       => 'main restricted universe multiverse',
    include_src => true,
  }
  ::apt::source { 'ubuntu-security':
    location    => 'http://security.ubuntu.com/ubuntu/',
    release     => "${::lsbdistcodename}-security",
    repos       => 'main restricted universe multiverse',
    include_src => true,
  }
  ::apt::source { 'ubuntu-zabbix':
    location    => 'http://repo.zabbix.com/zabbix/2.0/ubuntu',
    release     => $::lsbdistcodename,
    repos       => 'main',
    include_src => true,
  }
}

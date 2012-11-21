# Class: admin-tools
#
# This modules installs basic administration utilities
#

class admin-tools {
  # centos 6 minimal
  package { 'openssh-clients': ensure => latest }
  package { 'wget':         ensure => latest, }
  package { 'rsync':        ensure => latest, }
  package { 'bind-utils':   ensure => latest, }
  # admin tools
  package { 'nmap':         ensure => latest, }
  package { 'screen':       ensure => latest, }
  package { 'zsh':          ensure => latest, }
  package { 'atop':         ensure => latest, }
  package { 'htop':         ensure => latest, }
  package { 'mutt':         ensure => latest, }
  package { 'vim-enhanced': ensure => latest, }
  package { 'iftop':        ensure => latest, }
  package { 'iotop':        ensure => latest, }
  package { 'tcpdump':      ensure => latest, }
  package { 'mc':           ensure => latest, }
  package { 'ncdu':         ensure => latest, }
  package { 'strace':       ensure => latest, }
  package { 'telnet':       ensure => latest, }
  package { 'lsof':         ensure => latest, }
  # yum helpers
  package { 'yum-utils':    ensure => latest, }
  case $::operatingsystemrelease {
    default : {}
    '5.8' : {
      package { 'yum-allowdowngrade': ensure => latest, }
      package { 'yum-changelog':      ensure => latest, }
      package { 'yum-downloadonly':   ensure => latest, }
      package { 'yum-merge-conf':     ensure => latest, }
      package { 'yum-priorities':     ensure => latest, }
      package { 'yum-protectbase':    ensure => latest, }
      package { 'yum-security':       ensure => latest, }
      package { 'yum-upgrade-helper': ensure => latest, }
      package { 'yum-versionlock':    ensure => latest, }
    }
    '6.2' : {
      package { 'yum-plugin-changelog':      ensure => latest, }
      package { 'yum-plugin-downloadonly':   ensure => latest, }
      package { 'yum-plugin-merge-conf':     ensure => latest, }
      package { 'yum-plugin-priorities':     ensure => latest, }
      package { 'yum-plugin-protectbase':    ensure => latest, }
      package { 'yum-plugin-upgrade-helper': ensure => latest, }
      package { 'yum-plugin-versionlock':    ensure => latest, }
    }
    '6.3' : {
      package { 'yum-plugin-changelog':      ensure => latest, }
      package { 'yum-plugin-downloadonly':   ensure => latest, }
      package { 'yum-plugin-merge-conf':     ensure => latest, }
      package { 'yum-plugin-priorities':     ensure => latest, }
      package { 'yum-plugin-protectbase':    ensure => latest, }
      package { 'yum-plugin-upgrade-helper': ensure => latest, }
      package { 'yum-plugin-versionlock':    ensure => latest, }
    }
  }
  # postfix
  package { 'postfix':                 ensure => latest, }
}

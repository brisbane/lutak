# Class: yumreposd::srce_intern
#
# This module manages srce_intern repo files for $lsbdistrelease
#
class yumreposd::srce_intern {
  # install package depending on major version
  case $::operatingsystemrelease {
    default : { }
    /^5.*/: {
      package { 'srce-release-intern' :
        ensure   => '5-3.el5.srce',
        provider => 'rpm',
        source   => 'http://ftp.srce.hr/srce-redhat/base/el5/x86_64/srce-release-intern-5-3.el5.srce.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'srce-release-intern' :
        ensure   => '5-3.el6.srce',
        provider => 'rpm',
        source   => 'http://ftp.srce.hr/srce-redhat/base/el6/x86_64/srce-release-intern-5-3.el6.srce.noarch.rpm',
      }
    }
  }
}

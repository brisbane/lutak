# Class: vmtools::xvp
#
# Installs the XVP
class vmtools::xvp (
  $package_ensure = 'present',
){
  package { 'xvp' :
    ensure   => $package_ensure,
  }
}

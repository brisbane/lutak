# Class: jenkins::selenium
#
# This module manages selenium as extension to jenkins
#
class jenkins::selenium (
  $package_ensure = $jenkins::params::package_ensure,
  $java_version   = $jenkins::params::java_version,
) inherits jenkins::params {
  require jenkins
  require admintools::xvfb
  require admintools::imagemagick
  require admintools::firefox
  require admintools::chrome
}

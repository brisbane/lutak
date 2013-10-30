# Class: java::oracle7::fonts
#
# This module manages java fonts package from srce repo for Java 7
#
class java::oracle7::fonts {
  require ::yum::repo::srce::intern

  # fonts are already included in main java package
  include ::java::oracle7
}

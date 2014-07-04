# Class: java::oracle7::jce
#
# Installs JCE (Crypto Extensions) for Oracle Java 7
#
class java::oracle7::jce {
  require ::yum::repo::srce::intern

  package { 'java-1.7.0-oracle-jce-policy':
    ensure   => present,
  }
}

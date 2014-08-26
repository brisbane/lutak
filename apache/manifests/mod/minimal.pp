# Class: apache::mod::minimal
# - installs minimal set of apache modules
class apache::mod::minimal {
  apache::mod { 'alias': }
  apache::mod { 'auth_basic': }
  apache::mod { 'authn_alias': }
  apache::mod { 'authz_host': }
  apache::mod { 'authz_user': }
  apache::mod { 'dir': }
  apache::mod { 'headers': }
  apache::mod { 'log_config': }
  apache::mod { 'mime': }
  include ::apache::mod::rewrite
  include ::apache::mod::setenvif
}

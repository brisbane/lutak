#
# = Class: redmine::dependency
#
# This class lists dependencies for class redmine
#
class redmine::dependency {
  include ::yum::repo::passenger
  include ::yum::repo::srce::test
  include ::ruby::gems
  include ::ruby::gem::rails
}

# Class: torqueclient::repos
#
# Virtual module that requires emi2 repos
#
class torqueclient::repos {
  include yumreposd::umd2
}

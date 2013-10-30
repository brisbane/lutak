#
# = Class: desktop::google::talkplugin
#
# This module installs Google TalkPlugin
#
class desktop::google::talkplugin {

  package { 'google-talkplugin': ensure => present, }

}

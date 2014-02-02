# Class: dropbox
#
# Installs Dropbox
#
class dropbox {
  package {'dropbox':
    ensure   => latest,
  }
  service {'dropbox':
    ensure   => running,
    enable   => true,
    provider => redhat,
  }
}

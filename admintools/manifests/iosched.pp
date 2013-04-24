# Define: admintools::iosched
#
# This define sets io scheduler for block device
#
define admintools::iosched(
  $block,
  $elevator,
) {

  # find out what are we up against
  case $elevator {
    default: {
      $scheduler = 'cfq'
    }
    /noop/: {
      $scheduler = 'noop'
    }
    /deadline/: {
      $scheduler = 'deadline'
    }
    /anticipatory/: {
      $scheduler = 'anticipatory'
    }
  }

  # exec { 'set_elevator':
  #   command => "",
  # }

  # echo noop > /sys/block/<device>/queue/scheduler
}

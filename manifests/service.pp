# Run service
class ignore_update::service {
  $items = $ignore_update::items

  if $ignore_update::supported != false {
    if $facts['ignored_updates'] != $items {
      exec { 'reset ignored updates':
        before  => Exec['add items to ignored updates'],
        command => '/usr/sbin/softwareupdate --reset-ignored',
      }

      if ($items) and ($items != []) {
        $items_string = join(['"', join($items, '" "'), '"'])
        exec { 'add items to ignored updates':
          command => "/usr/sbin/softwareupdate --ignore ${items_string}",
        }
      }
    }
  }
}

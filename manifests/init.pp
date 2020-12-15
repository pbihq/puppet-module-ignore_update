# Class: ignore_update
#
# Runs ignore_update
class ignore_update (
  Optional[Array[String]] $items,
)
{
  # Make sure this will only be applied to macOS machines
  if $facts['os']['family'] != 'Darwin' {
    fail('The ignore_update module is only supported on macOS')
  }

  # Make sure this will only be applied to macOS up until 10.15
  # macOS 10.15 == '19', macOS 11 == '20', ...
  if $facts['os']['release']['major'] > '19' {
    warning('The ignore_update module is not supported on macOS 11 and higher')
    $supported = false
  }

  include ignore_update::service
}

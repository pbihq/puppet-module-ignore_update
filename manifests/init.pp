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
  } else {
      include ignore_update::service
  }
}

# puppet-module-ignore_update

This Puppet module allows you to manage ignored system software updates on macOS.
It is essentially just a wrapper for the built-in 'softwareupdate' binary.
This is particularly useful for delaying major macOS upgrades.

## How to use this module

### Identifying software items to ignore

First, we need to find out the identifiers of the software we want to ignore:

```shell
softwareupdate --list
```

Sample output:

```shell
Software Update found the following new or updated software:
   * macOS Mojave 10.14.6 Supplemental Update 2-
  macOS Mojave 10.14.6 ergänzendes Update 2 ( ), 1223724K [recommended] [restart]
   * Safari13.0.2MojaveAuto-13.0.2
  Safari (13.0.2), 67268K [recommended]
```

The identifier for each item "is the first part of the item name (before the dash
and version number)" (manpage for softwareupdate).

Hence, our resulting list of identifiers is:

- "macOS Mojave 10.14.6 Supplemental Update 2"
- "Safari13.0.2MojaveAuto"

### Adding software items to Hiera

Now that we have identified the names of our items we want to ignore, we can add
them to Hiera.

Ordinarily you would run the following command on a local machine to ignore the
identified software updates:

```shell
softwareupdate --ignore \
  "macOS Mojave 10.14.6 Supplemental Update 2" \
  "Safari13.0.2MojaveAuto"
```

This is equivalent to the following YAML array in Hiera:

```yaml
classes:
  - ignore_update

ignore_update::items:
  - macOS Mojave 10.14.6 Supplemental Update 2
  - Safari13.0.2MojaveAuto
```

### Ignoring software upgrade for macOS Catalina

As of macOS 10.14.6 users are being prompted to install macOS Catalina directly
via System Settings' Software Update pane. Add "macOS Catalina" to hide this
prompt.

```yaml
classes:
  - ignore_update

ignore_update::items:
  - macOS Catalina
```

### Reset

To reset the list of ignored updates, remove the "ignore_update::items"
key, remove its value or set it to an empty array

```yaml
classes:
  - ignore_update

ignore_update::items: []
```

## Miscellaneous

Tested with Puppet 5 on macOS 10.14.6

For further information have a look at the manpage for "softwareupdate".

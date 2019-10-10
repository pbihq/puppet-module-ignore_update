# ignored_updates.rb
Facter.add(:ignored_updates) do
  confine kernel: 'Darwin'
  setcode do
    # rubocop:disable LineLength
    output = Facter::Util::Resolution.exec('/usr/sbin/softwareupdate --ignore')
        .delete("\n")
    # rubocop:enable LineLength
    entries = []
    if output == 'Ignored updates:()'
      entries
    elsif output =~ /^Ignored updates:/
      entries = output[/"[^"].*"/] # Match all results in quotes
        .delete('"')      # Remove quotes
        .gsub(/\s+/, '')  # Remove leading and trailing white space
        .split(',')       # Create array by splitting entries on commas
      entries
    else
      "Error parsing ignored updates from 'softwareupdate'"
    end
  end
end

IO.popen("/usr/local/bin/drush vget").readlines.each do |line|
  next if line =~ /(?:^[\s\(\)]|^\s*$|:\s*Array\s*$)/
  match = line.match(/(\S+):\s*(\S.*)/) or next
  Facter.add("drupal_#{match[1]}") do
    setcode { match[2].gsub(/^"|"$/, "") }
  end
end

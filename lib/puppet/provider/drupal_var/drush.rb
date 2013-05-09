require 'facter'

# Eventually should confine to only try when we have drush

Puppet::Type.type(:drupal_var).provide(:drush) do
  desc "Uses drush to set Drupal variables"
  commands :drush => 'drush'

  def exists?
    begin
      drush("vget", resource[:var_name]).chomp
    rescue
      nil
    end

  end

  def create
    drush 'vset', resource[:var_name], resource[:value]
  end

  def destroy
    drush "vdel", "-y", resource[:var_name]
  end

  def value
    begin
      # vget --format=json conveniently doesn't have the ""
      # Really, we should re-use Fritz's code from the facter fact, but we
      # forgot about that until we'd written the code below...
      drush(%w(vget --format=json), resource[:var_name]).
        chomp.
        gsub(/^"/,"").
        gsub(/"$/,"")
    rescue
      nil
    end
  end

  def value=(val)
    drush 'vset', resource[:var_name], val
  end

end

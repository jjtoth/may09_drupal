Puppet::Type.newtype(:drupal_var) do
  desc "Set Drupal variables"

  ensurable

  newparam(:var_name) do
    desc "Name of Drupal Variable"
    isnamevar
  end

  newproperty(:value) do
    desc "Current value of Drupal variable"
  end

end

Warden::Manager.after_authentication do |user,auth,opts|
  admin = false
  memberships = Devise::LDAP::Adapter.get_ldap_param(user.login, 'memberOf')

  memberships.each do |group|
    group.downcase!
  end

  if memberships.include?(Fml::Application.config.admin_group)
    admin = true
  end

  if user[:is_admin] ^ admin
    user.update_attribute(:is_admin, admin)
  end
end

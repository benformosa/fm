Warden::Manager.after_authentication do |user,auth,opts|
  admin = false

  if(Devise::LDAP::Adapter.in_ldap_group?(user.login, Fm::Application.config.admin_group, Fm::Application.config.admin_group_attribute))
    admin = true
  end

  if user[:is_admin] ^ admin
    user.update_attribute(:is_admin, admin)
  end
end

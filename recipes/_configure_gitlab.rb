# encoding: utf-8
# Load LDAP information from encrypted data bag for better security
data_bag_name = node['gitlab-omni']['ldap_data_bag_name']
data_bag_item = node['gitlab-omni']['ldap_data_bag_item']
begin
  db_ldap = Chef::EncryptedDataBagItem.load(
    data_bag_name,
    data_bag_item
  ) if node['gitlab-omni']['rails']['config']['ldap_enabled']
rescue
  raise 'You have https enabled but I was unable to load your data bag' \
    "(#{data_bag_name}, #{data_bag_item}) containing the information"
end

template '/etc/gitlab/gitlab.rb' do
  source 'gitlab.rb.erb'
  user 'root'
  group 'root'
  mode '600'
  variables('ldap_host' => db_ldap['host'],
            'ldap_port' => db_ldap['port'],
            'ldap_uid' => db_ldap['uid'],
            'ldap_method' => db_ldap['method'],
            'ldap_bind_dn' => db_ldap['bind_dn'],
            'ldap_password' => db_ldap['password'],
            'ldap_allow_username_or_email_login' => db_ldap['allow_username_or_email_login'],
            'ldap_base' => db_ldap['base'],
            'ldap_user_filter' => db_ldap['user_filter']
           ) if node['gitlab-omni']['rails']['config']['ldap_enabled']
end

# Setup a backup cron
cron 'gitlab-backup' do
  minute node['gitlab-omni']['backup']['minute']
  hour node['gitlab-omni']['backup']['hour']
  weekday node['gitlab-omni']['backup']['weekday']
  command '/opt/gitlab/bin/gitlab-rake gitlab:backup:create'
  only_if { node['gitlab-omni']['backup']['enabled'] }
end

# Setup logrotation
logrotate_app 'gitlab' do
  cookbook 'logrotate'
  path node['gitlab-omni']['logrotate']['path']
  frequency node['gitlab-omni']['logrotate']['frequency']
  options node['gitlab-omni']['logrotate']['options']
  rotate node['gitlab-omni']['logrotate']['rotate']
end

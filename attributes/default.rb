# Package information
# Load package information depending on node configuration
default['gitlab-omni']['omnibus']['url'] = value_for_platform(
  'debian' => {
    'default' => 'https://downloads-packages.s3.amazonaws.com/debian-7.6/gitlab_7.3.2-omnibus-1_amd64.deb'
  },
  'ubuntu' => {
    '12.04' => 'https://downloads-packages.s3.amazonaws.com/ubuntu-12.04/gitlab_7.3.2-omnibus-1_amd64.deb',
    '14.04' => 'https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.3.2-omnibus-1_amd64.deb'
  },
  'centos' => {
    '7.0' => 'https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-7.3.2_omnibus-1.el7.x86_64.rpm',
    '7.0.1406' => 'https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-7.3.2_omnibus-1.el7.x86_64.rpm',
    '6.5' => 'https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.3.2_omnibus-1.el6.x86_64.rpm'
  }
)
default['gitlab-omni']['omnibus']['checksum'] = value_for_platform(
  'debian' => {
    'default' => '8cadae4bee9aba0ffdb1025d1075c1a3fcd973ffb3b292b6592a5ab6179dcd16'
  },
  'ubuntu' => {
    '12.04' => '36b7a1c449c94da27c807391e08c371a0385c50202596750a5244930f2c1b1e0',
    '14.04' => 'b0551e4f8e18dce0c6848c9e2498b57a00904b5710b4665a000941d0faff6c4f'
  },
  'centos' => {
    '7.0' => 'c3de7aa6979997190014660ac1bb4848879e8bdcdd797e8231d07446feb1b3db',
    '7.0.1406' => 'c3de7aa6979997190014660ac1bb4848879e8bdcdd797e8231d07446feb1b3db',
    '6.5' => 'df57fea7cf3025f515424525a7f49c0c4a4d70f34fb41df7435d5972f35db70a'
  }
)

# Log rotation
default['gitlab-omni']['logrotate']['path'] = ['/var/log/gitlab/gitlab-rails/*.log',
                                               '/var/log/gitlab/nginx/*.log',
                                               '/var/log/gitlab/gitlab-shell/gitlab-shell.log',
                                               '/var/log/gitlab/unicorn/*.log']
default['gitlab-omni']['logrotate']['frequency'] = 'daily'
default['gitlab-omni']['logrotate']['rotate'] = 14
default['gitlab-omni']['logrotate']['options'] = ['missingok', 'compress', 'notifempty', 'copytruncate']



# Some data bag information in case we want to modify this on the fly
default['gitlab-omni']['ldap_data_bag_name'] = 'gitlab'
default['gitlab-omni']['ldap_data_bag_item'] = 'ldap'
default['gitlab-omni']['certificate_data_bag_name'] = 'gitlab'
default['gitlab-omni']['certificate_data_bag_item'] = 'certificate'

# This is the nginx configuration block to configure the gitlab.rb which generates the vhost for gitlab, see
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/templates/default/nginx-gitlab-http.conf.erb
# This certificate is loaded from the gitlab nginx encrypted databag
default['gitlab-omni']['nginx']['config']['redirect_http_to_https'] = true
default['gitlab-omni']['nginx']['config']['ssl_certificate'] = '/etc/gitlab/ssl/' + node['fqdn'] + '.crt'
default['gitlab-omni']['nginx']['config']['ssl_certificate_key'] = '/etc/gitlab/ssl/' + node['fqdn'] + '.key'

# Default backup cycles, each day at 2 AM system time
default['gitlab-omni']['backup']['enabled'] = true
default['gitlab-omni']['backup']['minute'] = '0'
default['gitlab-omni']['backup']['hour'] = '2'
default['gitlab-omni']['backup']['weekday'] = '*'

# Some static configuration variables used in the /etc/gitlab/gitlab.rb
default['gitlab-omni']['config']['external_url'] = 'https://' + node['fqdn']
default['gitlab-omni']['config']['git_data_dir'] = '/var/opt/gitlab/git-data'

# This is the gitlab configuration block to configure the gitlab.rb which generates the gitlab.yml, see
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/templates/default/gitlab.yml.erb
# LDAP information has been moved into the gitlab ldap encrypted databag
default['gitlab-omni']['rails']['config']['ldap_enabled'] = false
default['gitlab-omni']['rails']['config']['gitlab_default_projects_features_visibility_level'] = 'internal'
default['gitlab-omni']['rails']['config']['gravatar_enabled'] = true
default['gitlab-omni']['rails']['config']['gitlab_email_from'] = 'gitlab@' + node['domain']
default['gitlab-omni']['rails']['config']['smtp_enable'] = false
default['gitlab-omni']['rails']['config']['smtp_address'] = 'localhost'
default['gitlab-omni']['rails']['config']['smtp_port'] = 25
default['gitlab-omni']['rails']['config']['smtp_domain'] = node['domain']
default['gitlab-omni']['rails']['config']['smtp_authentication'] = 'login'
default['gitlab-omni']['rails']['config']['smtp_user_name'] = nil
default['gitlab-omni']['rails']['config']['smtp_password'] = nil
default['gitlab-omni']['rails']['config']['smtp_enable_starttls_auto'] = true

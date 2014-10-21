# encoding: utf-8
bash 'gitlab-setup' do
  action :nothing
  user 'root'
  code 'gitlab-ctl reconfigure'
  subscribes :run, 'dpkg_package[gitlab]', :delayed
  subscribes :run, 'template[/etc/gitlab/gitlab.rb]', :delayed
end

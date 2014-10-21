# encoding: utf-8
# Download and install Omnibus package, bail if we are missing the URL or checksum
if node['gitlab-omni']['omnibus']['url'].nil? || node['gitlab-omni']['omnibus']['checksum'].nil?
  fail 'Unable to find download URL or checksum for platform ' +
    node['platform'] + ', version ' + node['platform_version']
else
  url = node['gitlab-omni']['omnibus']['url']
  checksum = node['gitlab-omni']['omnibus']['checksum']
  file = Chef::Config[:file_cache_path] + '/' +
    File.basename(URI.parse(url).path)
end

remote_file file do
  source url
  checksum checksum
  notifies :install, 'package[gitlab]', :immediately
end

package 'gitlab' do
  provider Chef::Provider::Package::Dpkg if node['platform'] == 'debian' || node['platform'] == 'ubuntu'
  action :nothing
  source file
end

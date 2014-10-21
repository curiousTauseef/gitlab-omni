# encoding: utf-8
# Load SSL certificates from encrypted data bag
if node['gitlab-omni']['config']['external_url'].start_with?('https')
  data_bag_name = node['gitlab-omni']['certificate_data_bag_name']
  data_bag_item = node['gitlab-omni']['certificate_data_bag_item']
  begin
    db_nginx = Chef::EncryptedDataBagItem.load(data_bag_name, data_bag_item)
  rescue
    raise 'You have https enabled but I was unable to load your data bag' \
          "(#{data_bag_name}, #{data_bag_item}) containing the information"
  end

  # Create folder for cert/key files
  dirs = Set.new
  [node['gitlab-omni']['nginx']['config']['ssl_certificate'],
   node['gitlab-omni']['nginx']['config']['ssl_certificate_key']].each do |file|
    dirs << File.dirname(file)
  end

  dirs.each do |dir|
    directory dir do
      user 'root'
      group 'root'
      mode '700'
      action :create
    end
  end

  file node['gitlab-omni']['nginx']['config']['ssl_certificate'] do
    owner 'root'
    group 'root'
    mode '0600'
    content "#{db_nginx['cert']}\n#{db_nginx['ca']}\n"
  end

  file node['gitlab-omni']['nginx']['config']['ssl_certificate_key'] do
    owner 'root'
    group 'root'
    mode '0600'
    content db_nginx['certkey']
  end
end

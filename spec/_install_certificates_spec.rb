# encoding: utf-8
require 'spec_helper'

@platforms.each do |platform, versions|
  versions.each do |version|
    describe "The gitlab-omni::_install_certificates #{platform} version #{version} recipe" do
      before do
        allow(Chef::EncryptedDataBagItem).to receive(:load).with(
          'gitlab', 'certificate'
        ).and_return('cert' => 'testingcert',
                     'ca' => 'testingca',
                     'certkey' => 'testingkey')
        @chef_run = ChefSpec::SoloRunner.new(platform: platform,
                                             version: version)
        @chef_run.converge 'gitlab-omni::_install_certificates'
      end
      it 'should create /etc/gitlab/ssl' do
        expect(@chef_run).to create_directory('/etc/gitlab/ssl').with(owner: 'root', mode: '700')
      end
      it 'should create certificate bundle' do
        file = @chef_run.node['gitlab-omni']['nginx']['config']['ssl_certificate']
        expect(@chef_run).to render_file(file).with_content("testingcert\ntestingca")
        expect(@chef_run).to create_file(file).with(owner: 'root', group: 'root', mode: '0600')
      end

      it 'should create private key' do
        file = @chef_run.node['gitlab-omni']['nginx']['config']['ssl_certificate_key']
        expect(@chef_run).to render_file(file).with_content('testingkey')
        expect(@chef_run).to create_file(file).with(owner: 'root', group: 'root', mode: '0600')
      end
    end
  end
end

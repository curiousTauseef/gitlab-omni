# encoding: utf-8
require 'spec_helper'

@platforms.each do |platform, versions|
  versions.each do |version|
    describe "The gitlab-omni::_install_from_omnibus #{platform} version #{version} recipe" do
      before do
        @chef_run = ChefSpec::SoloRunner.new(platform: platform, version: version)
        @chef_run.converge 'gitlab-omni::_install_from_omnibus'
        @file = "#{Chef::Config[:file_cache_path]}/" +
          File.basename(URI.parse(@chef_run.node['gitlab-omni']['omnibus']['url']).path)
      end
      it 'should download Gitlab Omnibus Package' do
        expect(@chef_run).to create_remote_file(@file)
      end
      it 'should notify package installation' do
        resource = @chef_run.remote_file(@file)
        expect(resource).to notify('package[gitlab]').to(:install).immediately
      end
      it 'should not install the package automatically' do
        expect(@chef_run).not_to install_package('gitlab')
      end
    end
  end
end

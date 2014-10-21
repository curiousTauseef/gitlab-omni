# encoding: utf-8
require 'spec_helper'

@platforms.each do |platform, versions|
  versions.each do |version|
    describe "The gitlab-omni::default #{platform} version #{version} recipe" do
      before do
        allow(Chef::EncryptedDataBagItem).to receive(:load).with(
          'gitlab', 'certificate'
        ).and_return('')
        allow(Chef::EncryptedDataBagItem).to receive(:load).with('gitlab', 'ldap').and_return('')
        @chef_run = ChefSpec::SoloRunner.new(platform: platform, version: version)
        @chef_run.converge 'gitlab-omni::default'
      end

      %w(gitlab-omni::_definitions
         gitlab-omni::_install_from_omnibus
         gitlab-omni::_install_certificates
         gitlab-omni::_configure_gitlab).each do |rcp|
        it 'should include recipe ' + rcp do
          expect(@chef_run).to include_recipe rcp
        end
      end
    end
  end
end

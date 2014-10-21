# encoding: utf-8
require 'spec_helper'

@platforms.each do |platform, versions|
  versions.each do |version|
    describe "The gitlab-omni::_definitions #{platform} version #{version} recipe" do
      before do
        @chef_run = ChefSpec::SoloRunner.new(platform: platform,
                                             version: version)
        @chef_run.converge 'gitlab-omni::_definitions'
      end

      it 'bash[gitlab-setup] should do nothing' do
        resource = @chef_run.bash('gitlab-setup')
        expect(resource).to do_nothing
      end

      # Doesn't work as expected yet
      it 'should subscribe to other resources'
    end
  end
end

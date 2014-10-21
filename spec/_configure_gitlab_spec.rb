# encoding: utf-8
require 'spec_helper'

@platforms.each do |platform, versions|
  versions.each do |version|
    describe "The gitlab-omni::_configure_gitlab #{platform} version #{version} recipe" do
      before do
        @chef_run = ChefSpec::SoloRunner.new(platform: platform,
                                             version: version)
        @chef_run.converge 'gitlab-omni::_configure_gitlab'
      end

      it 'should create /etc/gitlab/gitlab.rb' do
        content = "external_url 'https:\/\/#{@chef_run.node['fqdn']}'\n" \
                  "git_data_dir '#{@chef_run.node['gitlab-omni']['config']['git_data_dir']}'"
        expect(@chef_run).to render_file('/etc/gitlab/gitlab.rb').with_content(
          Regexp.new Regexp.escape content
        )
      end
      it 'should create backup cronjob' do
        expect(@chef_run).to create_cron('gitlab-backup').with(
          minute: '0', hour: '2', weekday: '*',
          command: '/opt/gitlab/bin/gitlab-rake gitlab:backup:create'
        )
      end
    end
  end
end

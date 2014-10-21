# encoding: utf-8

require 'spec_helper'

describe command('gitlab-rake gitlab:check') do
  it { should return_exit_status 0 }
end

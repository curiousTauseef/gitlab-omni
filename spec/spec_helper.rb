# encoding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/deprecations'

@platforms = { 'ubuntu' => ['12.04', '14.04'], 'debian' => ['7.6'], 'centos' => ['6.5', '7.0'] }

at_exit { ChefSpec::Coverage.report! }

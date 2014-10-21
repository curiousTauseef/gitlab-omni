# encoding: utf-8
include_recipe 'gitlab-omni::_definitions'
include_recipe 'gitlab-omni::_install_from_omnibus'
include_recipe 'gitlab-omni::_install_certificates'
include_recipe 'gitlab-omni::_configure_gitlab'

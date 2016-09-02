#
# Cookbook Name:: django
# Recipe:: git_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'git'
package 'python3-pip'

git 'clone_django' do
  action :checkout
  revision 'master'
  repository 'git://github.com/django/django'
  destination '/opt/django-dev'
end

execute 'sudo pip3 install -e /opt/django-dev'

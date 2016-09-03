#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Translated Instructions From:
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis
#
version_number = node['redis']['version']
retrieve_folder = node['redis']['retrieve']

execute "apt-get update"

package "build-essential"

package "tcl8.5"

remote_file 'get_redis_archive' do
  path "#{retrieve_folder}/redis-#{version_number}.tar.gz"
  source "http://download.redis.io/releases/redis-#{version_number}.tar.gz"
  notifies :run, "execute[unzip_redis_archive]", :immediately
end

execute 'unzip_redis_archive' do
  command "tar xzf #{retrieve_folder}/redis-#{version_number}.tar.gz"
  cwd "#{retrieve_folder}"
  action :nothing
  notifies :run, "execute[make_make_install]", :immediately
end

execute 'make_make_install' do
  command "make && make install"
  cwd "#{retrieve_folder}/redis-#{version_number}"
  action :nothing
  notifies :run, "execute[install_server]", :immediately
end

execute 'install_server' do
  command "echo -n | ./install_server.sh"
  cwd "#{retrieve_folder}/redis-#{version_number}/utils"
  action :nothing
end

service "redis_6379" do
  action [ :start ]
  # This is necessary so that the service will not keep reporting as updated
  supports :status => true
end

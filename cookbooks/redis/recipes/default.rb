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


execute "apt-get update"

package "build-essential"

package "tcl8.5"

remote_file 'get_redis_archive' do
  path "/tmp/redis-#{version_number}.tar.gz"
  source "http://download.redis.io/releases/redis-#{version_number}.tar.gz"
  notifies :run, "execute[unzip_redis_archive]", :immediately
end

execute 'unzip_redis_archive' do
  command "tar xzf /tmp/redis-#{version_number}.tar.gz"
  cwd "/tmp"
  action :nothing
  notifies :run, "execute[make_make_install]", :immediately
end

execute 'make_make_install' do
  command "make && make install"
  cwd "/tmp/redis-#{version_number}"
  action :nothing
  notifies :run, "execute[install_server]", :immediately
end

execute 'install_server' do
  command "echo -n | ./install_server.sh"
  cwd "/tmp/redis-#{version_number}/utils"
  action :nothing
end

service "redis_6379" do
  action [ :start ]
  # This is necessary so that the service will not keep reporting as updated
  supports :status => true
end

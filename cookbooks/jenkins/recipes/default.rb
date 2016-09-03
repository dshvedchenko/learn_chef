#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

remote_file '/tmp/jenkins-ci.org.key' do
  source 'https://pkg.jenkins.io/debian/jenkins-ci.org.key'
  notifies :run, 'execute[add_jenkins_key]', :immediately
end

execute 'add_jenkins_key' do
  action :nothing
  command 'apt-key add /tmp/jenkins-ci.org.key'
end

file '/etc/apt/sources.list.d/jenkins.list' do
  action :nothing
  content 'deb http://pkg.jenkins.io/debian-stable binary/'
  notifies :run, 'execute[apt-get update]', :immediately
end

execute 'apt-get update' do
  action :nothing
end

package 'openjdk-7-jre-headless'
package 'jenkins'

service 'jenkins' do
  action [:start, :enable]
end

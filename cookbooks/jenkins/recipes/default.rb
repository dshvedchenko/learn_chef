#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#include_recipe 'apt::default' -- already in chef

apt_repository 'jenkins' do
    uri          node['jenkins']['master']['repository']
    distribution 'binary/'
    key          node['jenkins']['master']['repository_key']
    unless node['jenkins']['master']['repository_keyserver'].nil?
      keyserver    node['jenkins']['master']['repository_keyserver']
    end
  end

package 'openjdk-7-jre-headless'
package 'jenkins'

service 'jenkins' do
  action [:start, :enable]
end

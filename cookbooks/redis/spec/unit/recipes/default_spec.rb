#
# Cookbook Name:: redis
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'redis::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(step_into: ['redis']) do |node,server|
        node.default['redis']['version_number'] = '3.0.0'
      end
      runner.converge(described_recipe)
    end

    let(:redis_version) {'3.0.0'}

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'updates packages' do
      expect(chef_run).to run_execute('apt-get update')
    end

    it 'install necessary packages' do
      expect(chef_run).to install_package('build-essential')
      expect(chef_run).to install_package('tcl8.5')
    end

    it 'installs redis' do
      expect(chef_run).to install_redis("#{redis_version}")
    end

    it 'recieve remove redis archive' do
      expect(chef_run).to create_remote_file("/tmp/redis-#{redis_version}.tar.gz")
    end

    it 'installs the redis from source' do
      resource = chef_run.remote_file('get_redis_archive')
      expect(resource).to notify('execute[unzip_redis_archive]').to(:run).immediately
    end

    it 'make_and_install' do
      resource = chef_run.execute('unzip_redis_archive')
      expect(resource).to notify('execute[make_make_install]').to(:run).immediately
    end

    it 'install_server' do
      resource = chef_run.execute('make_make_install')
      expect(resource).to notify('execute[install_server]').to(:run).immediately
    end

    it 'start_server' do
      expect(chef_run).to start_service('redis_6379')
    end

  end
end

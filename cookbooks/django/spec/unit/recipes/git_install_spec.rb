#
# Cookbook Name:: django
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'django::git_install' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs necessary packages' do
      expect(chef_run).to install_package('python3-pip')
      expect(chef_run).to install_pip('django')
      # expect(chef_run).to git('git')
    end

    it 'installs django framework' do
      expect(chef_run).to run_execute('sudo pip3 install -e ~/django-dev')
    end
  end
end

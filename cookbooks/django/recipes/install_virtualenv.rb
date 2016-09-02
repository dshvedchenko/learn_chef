#
# Cookbook Name:: django
# Recipe:: install_virtual_env
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'python3-pip'

execute 'pip3 install virtualenv'

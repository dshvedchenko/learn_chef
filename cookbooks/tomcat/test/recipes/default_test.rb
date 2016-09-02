# # encoding: utf-8

# Inspec test for recipe tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe bash('curl http://localhost:8080') do
  its('stdout') { should match /Tomcat/ }
end

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

describe group('tomcat') do
  it { should exist }
end

describe user('tomcat') do
  its('group') { should eq 'tomcat' }
  its('home') { should eq '/opt/tomcat' }
  its('shell') { should eq '/bin/nologin' }
end

describe file ("#{node['tomcat']['dir']}") do
  it { should exist }
  it { should be_directory }
end

describe file('/opt/tomcat/conf') do
  it { should exist }
  its('mode') { should eq 0070 }
end

%w[ webapps work temp logs].each do |path|
  describe file("/opt/tomcat/#{path}") do
    it { should exist }
    it { should be_owned_by 'tomcat'}
  end
end

describe file('/etc/systemd/system/tomcat.service') do
  it { should exist }
end

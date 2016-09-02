
package 'java-1.7.0-openjdk-devel'

group "#{node['tomcat']['group']}"

user "#{node['tomcat']['user']}" do
  shell '/bin/nologin'
  home "#{node['tomcat']['dir']}"
  manage_home false
  group 'tomcat'
end

remote_file '/opt/apache-tomcat-8.0.36.tar.gz' do
  source 'http://apache.volia.net/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz'
  mode '0755'
  action :create
  not_if do ::File.exists?('/opt/apache-tomcat-8.0.36.tar.gz') end
  notifies :run, 'execute[unpack-tomcat]', :immediately
end

directory "#{node['tomcat']['dir']}" do
  action :create
end

execute 'unpack-tomcat' do
 command 'tar xvf /opt/apache-tomcat-8.0.36.tar.gz -C /opt/tomcat --strip-components=1'
end

execute "chgrp -R tomcat #{node['tomcat']['dir']}/conf"

directory "#{node['tomcat']['dir']}/conf" do
  mode '0070'
end

execute "chmod g+r #{node['tomcat']['dir']}/conf/*"

%w[ webapps work temp logs ].each do |path|
  execute "chown -R tomcat #{node['tomcat']['dir']}/#{path}"
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

#TODO: NOT DESIRED
execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end

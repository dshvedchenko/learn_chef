
package 'java-1.7.0-openjdk-devel'

group 'tomcat'

user 'tomcat' do
  shell '/bin/nologin'
  home '/opt/tomcat'
  manage_home false
  group 'tomcat'
end

remote_file '/opt/apache-tomcat-8.0.36.tar.gz' do
  source 'http://apache.volia.net/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz'
  mode '0755'
  action :create
  not_if do ::File.exists?('/opt/apache-tomcat-8.0.36.tar.gz') end
  notify :run, 'execute[unpack-tomcat]', :immediately
end

directory '/opt/tomcat' do
  action :create
end

execute 'unpack-tomcat' do
 command 'tar xvf /opt/apache-tomcat-8.0.36.tar.gz -C /opt/tomcat --strip-components=1'
end

execute 'chgrp -R tomcat /opt/tomcat/conf'

directory '/opt/tomcat/conf' do
  mode '0070'
end

execute 'chmod g+r /opt/tomcat/conf/*'

%w[ webapps work temp logs ].each do |path|
  execute "chown -R tomcat /opt/tomcat/#{path}"
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

#TODO: NOT DESIRED
execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end

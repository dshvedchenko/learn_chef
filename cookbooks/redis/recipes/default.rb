version_number = node['redis']['version']
retrieve_folder = node['redis']['retrieve']

execute "apt-get update"

package "build-essential"

package "tcl8.5"

redis "#{version_number}" do
  retrieve_folder "#{retrieve_folder}"
  action :install
  source "http://download.redis.io/releases/redis-#{version_number}.tar.gz"
end

service "redis_6379" do
  action [ :start ]
  # This is necessary so that the service will not keep reporting as updated
  supports :status => true
end

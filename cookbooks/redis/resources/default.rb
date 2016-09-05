actions :install

property :source, String
property :version_number, String, name_property: true
property :retrieve_folder, String

action :install do
  source_url = source

  remote_file 'get_redis_archive' do
    path "#{retrieve_folder}/redis-#{version_number}.tar.gz"
    source source_url
    require 'pry'; binding.pry
    # source "http://download.redis.io/releases/redis-#{version_number}.tar.gz"
    notifies :run, "execute[unzip_redis_archive]", :immediately
  end

  execute 'unzip_redis_archive' do
    command "tar xzf #{retrieve_folder}/redis-#{version_number}.tar.gz"
    cwd "#{retrieve_folder}"
    action :nothing
    notifies :run, "execute[make_make_install]", :immediately
  end

  execute 'make_make_install' do
    command "make && make install"
    cwd "#{retrieve_folder}/redis-#{version_number}"
    action :nothing
    notifies :run, "execute[install_server]", :immediately
  end

  execute 'install_server' do
    command "echo -n | ./install_server.sh"
    cwd "#{retrieve_folder}/redis-#{version_number}/utils"
    action :nothing
  end

end

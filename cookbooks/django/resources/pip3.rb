resource_name :pip3
property :pip_package, String, name_property: true

action :install do
  execute "pip3 install #{pip_package}"
end

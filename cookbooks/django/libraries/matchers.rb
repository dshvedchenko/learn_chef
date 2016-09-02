if defined?(ChefSpec)
  def install_django_pip3(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:django_pip3, :action, resource_name)
  end
end

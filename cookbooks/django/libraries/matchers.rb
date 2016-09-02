if defined?(ChefSpec)
  def install_pip(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:pip, :action, resource_name)
  end
end

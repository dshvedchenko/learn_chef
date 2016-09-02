# # encoding: utf-8

# Inspec test for recipe django::git_install

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe command('django-admin --version') do
  its(:stdout) { should match /1.11.dev20160901234603/ }
end

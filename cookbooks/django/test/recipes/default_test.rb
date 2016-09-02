# # encoding: utf-8

# Inspec test for recipe django::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe command('django-admin --version') do
  its(:stdout) { should match /1.6.1/ }
end

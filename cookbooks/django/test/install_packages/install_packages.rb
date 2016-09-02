# # encoding: utf-8

# Inspec test for recipe django::install_packages

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html
describe command('virtualenv --version') do
  its(:stdout) { should match /1.10.1/ }
end

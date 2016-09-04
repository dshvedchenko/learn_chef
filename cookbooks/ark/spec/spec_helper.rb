require 'chefspec'
require 'chefspec/berkshelf'
require 'pry'

at_exit { ChefSpec::Coverage.report! }

shared_examples 'necessary_packages' do
  it "installs package necessary packages" do
    packages.each do |package_name|
      expect(chef_run).to install_package(package_name)
    end
  end
end

shared_examples 'chef_runner' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(platform_details)
    runner.converge(described_recipe)
  end
end

require 'chefspec'
require 'chefspec/berkshelf'
require 'pry'

at_exit { ChefSpec::Coverage.report! }

shared_context 'chef_runner' do
  
  let(:platform_details) do
    {}
  end

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(platform_details)
    runner.converge(described_recipe)
  end

  let(:node) {chef_run.node}
  let(:attribute) { node['ark']}

end

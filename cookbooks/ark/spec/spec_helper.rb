require 'chefspec'
require 'chefspec/berkshelf'
require 'pry'

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  config.color = true
  config.alias_example_group_to :describe_recipe, type: :recipe
end


shared_context 'chef_runner', type: :recipe do

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(node_attributes).converge(described_recipe)
  end

  let(:node) {chef_run.node}
  let(:attribute) { node['ark']}


  def node_attributes
    {}
  end

end

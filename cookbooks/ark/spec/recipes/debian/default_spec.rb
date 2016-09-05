require 'spec_helper'

describe_recipe 'ark::default' do


  context 'when no attributes are specified, on Debian' do

    def node_attributes
      {platform: 'ubuntu', platform_family: 'debian', version: '14.04'}
    end

    # let(:chef_run) do
    #   runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', platform_family: 'debian', version: '14.04')
    #   runner.converge(described_recipe)
    # end

    let(:packages) do
      %w[ libtool autoconf unzip rsync make gcc autogen shtool pkg-config ]
    end

    it "installs package necessary packages" do
      packages.each do |package_name|
        expect(chef_run).to install_package(package_name)
      end
    end


  end

end

require 'spec_helper'

describe_recipe 'ark::default' do

  context 'when no attributes are specified, on FreeBSD' do

    def node_attributes
      {platform: 'freebsd', version: '10.2'}
    end
    # let(:chef_run) do
    #   runner = ChefSpec::SoloRunner.new(platform: 'freebsd', version: '10.2')
    #   runner.converge(described_recipe)
    # end

    let(:packages) do
      %w[ libtool autoconf unzip rsync gmake gcc autogen gtar ]
    end

    it "installs package necessary packages" do
      packages.each do |package_name|
        expect(chef_run).to install_package(package_name)
      end
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end
  end


end

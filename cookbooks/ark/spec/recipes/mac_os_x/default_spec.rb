require 'spec_helper'

describe 'ark::default' do

  context 'when no attributes are specified, on Mac OSX' do

    include_context 'chef_runner'

    let(:platform_details) do
      {platform: 'mac_os_x', version: '10.11.1'}
    end


    let(:notexpected_packages) do
      %w[ libtool autoconf unzip rsync make gcc]
    end

    it "not installs package necessary packages" do
      notexpected_packages.each do |package_name|
        expect(chef_run).not_to install_package(package_name)
      end
    end

    # it "tar binary" do
    #   binding.pry
    #   expect(attribute['tar']).to eq "/usr/bin/tar"
    # end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end

  end

end

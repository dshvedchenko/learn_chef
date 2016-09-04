require 'spec_helper'

describe 'ark::default' do

  context 'when no attributes are specified, on CentOS' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7')
      runner.converge(described_recipe)
    end

    let(:packages) do
      %w[ libtool autoconf unzip rsync make gcc bzip2 tar xz-lzma-compat]
    end

    include_examples 'necessary_packages'

  end
end

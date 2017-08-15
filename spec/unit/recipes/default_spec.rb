#
# Cookbook:: jenkins
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'jenkins::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'add a apt_repository for jenkins' do
      expect(chef_run).to add_apt_repository('jenkins')
    end

    it 'it installs package openjdk-8-jdk-headless' do
      expect(chef_run).to install_package('openjdk-8-jdk-headless')
    end

    it 'it installs package jenkins' do
      expect(chef_run).to install_package('jenkins')
    end

    it 'it starts service jenkins' do
      expect(chef_run).to start_service('jenkins')
    end

  end
end

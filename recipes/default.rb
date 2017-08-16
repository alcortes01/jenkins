#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if platform?('ubuntu')

  # Apt repository for Jenkins
  apt_repository 'jenkins' do
    uri 'https://pkg.jenkins.io/debian-stable'
    distribution 'binary/'
    key 'https://pkg.jenkins.io/debian-stable/jenkins.io.key'
  end

  # sudo apt-get install openjdk-8-jdk-headless
  package 'openjdk-8-jdk-headless'

  # sudo apt-get install jenkins
  package 'jenkins'

  # start jenkins
  service 'jenkins' do
    action :start
  end

end

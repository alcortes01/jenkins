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

if platform?('centos')

  # Yum repository for Jenkins
  yum_repository 'Jenkins' do
    description 'Jenkins stable repo'
    baseurl 'http://pkg.jenkins-ci.org/redhat'
    gpgkey 'https://jenkins-ci.org/redhat/jenkins-ci.org.key'
    action :add
  end

  # Install wget
  package 'wget' do
    action :install
  end

  # Install openjdk-8
  package 'java-1.8.0-openjdk-headless' do
    action :install
  end

  # Install Jenkins
  package 'jenkins' do
    action :install
  end

  # Enable and start Jenkins
  service 'jenkins' do
    action [:enable, :start]
  end

end

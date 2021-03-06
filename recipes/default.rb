#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if platform?('debian', 'ubuntu')
  # Apt repo update
  apt_update
  # Required by Jenkins
  package 'default-jre'
  # Apt repository for Jenkins
  apt_repository 'jenkins' do
    # uri 'http://pkg.jenkins.io/debian-stable'
    uri 'http://pkg.jenkins-ci.org/debian'
    distribution 'binary/'
    key 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key'
    # key 'http://pkg.jenkins.io/debian-stable/jenkins.io.key'
  end
end

if platform?('redhat', 'centos')
  # Required by jenkins
  package 'fontconfig'
  package 'java-1.8.0-openjdk-headless'
  # Yum repository for Jenkins
  yum_repository 'Jenkins' do
    description 'Jenkins stable repo'
    baseurl 'http://pkg.jenkins.io/redhat'
    gpgkey 'http://pkg.jenkins.io/redhat/jenkins.io.key'
    action :add
  end
end

# include_recipe 'java'

# Install Jenkins
package 'jenkins' do
  action :install
end

# Enable and start Jenkins
service 'jenkins' do
  action [:enable, :start]
end

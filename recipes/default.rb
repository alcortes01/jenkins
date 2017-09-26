#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'java'

if platform?('debian', 'ubuntu')

  # Apt repository for Jenkins
  apt_repository 'jenkins' do
    uri 'https://pkg.jenkins.io/debian-stable'
    distribution 'binary/'
    key 'https://pkg.jenkins.io/debian-stable/jenkins.io.key'
  end

end

if platform?('redhat', 'centos')

  # Yum repository for Jenkins
  yum_repository 'Jenkins' do
    description 'Jenkins stable repo'
    baseurl 'http://pkg.jenkins-ci.org/redhat'
    gpgkey 'https://jenkins-ci.org/redhat/jenkins-ci.org.key'
    action :add
  end

end

# Install Jenkins
package 'jenkins' do
  action :install
end

# Enable and start Jenkins
service 'jenkins' do
  action [:enable, :start]
end

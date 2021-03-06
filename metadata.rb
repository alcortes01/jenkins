name 'jenkins'
maintainer 'Alberto Cortes'
maintainer_email 'alcortes01@gmail.com'
license 'MIT'
description 'Installs/Configures jenkins'
long_description 'Installs/Configures jenkins'
version '1.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

%w(ubuntu debian centos redhat).each do |os|
  supports os
end

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/alcortes01/jenkins/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/alcortes01/jenkins'

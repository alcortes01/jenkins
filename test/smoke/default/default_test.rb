# # encoding: utf-8

# Inspec test for recipe jenkins::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('jenkins') do
  it { should be_installed }
end

describe port(8080) do
  it { should be_listening }
end

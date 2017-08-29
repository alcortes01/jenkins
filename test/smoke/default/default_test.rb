# # encoding: utf-8

# Inspec test for recipe jenkins::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os[:family] == 'debian'
  describe package('openjdk-8-jdk-headless') do
    it { should be_installed }
  end
  describe package('jenkins') do
    it { should be_installed }
  end
  describe port(8080) do
    it { should be_listening }
  end
elsif os[:family] == 'redhat'
  describe package('java-1.8.0-openjdk-headless') do
    it { should be_installed }
  end
  describe package('jenkins') do
    it { should be_installed }
  end
  describe port(8080) do
    it { should be_listening }
  end
end

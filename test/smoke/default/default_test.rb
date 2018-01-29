# # encoding: utf-8

# Inspec test for recipe jenkins::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
sleep 10
if os[:family] == 'debian'
  describe package('default-jre') do
    it { should be_installed }
  end
  describe package('jenkins') do
    it { should be_installed }
  end
  describe port(8080) do
    it { should be_listening }
  end
elsif os[:family] == 'redhat'
  describe package('java-1.8.0-openjdk') do
    it { should be_installed }
  end
  describe package('jenkins') do
    it { should be_installed }
  end
  describe port(8080) do
    it { should be_listening }
  end
end

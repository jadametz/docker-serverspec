require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')
    image.tag(repo: 'jadametz/serverspec', tag: 'latest')

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, image.id
  end

  describe package('build-base') do
    it { should be_installed }
  end

  describe file('/Gemfile') do
    it { should be_file }
  end

  describe file('/Gemfile.lock') do
    it { should be_file }
  end
end

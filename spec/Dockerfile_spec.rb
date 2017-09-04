require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')
    image.tag(repo: 'jadametz/serverspec', tag: 'latest')

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, image.id
    set :docker_container_create_options, { 'Entrypoint' => ['ash'] }
  end

  describe package('build-base') do
    it { should be_installed }
  end

  [
    'Gemfile',
    'Gemfile.lock',
  ].each do | file |
    describe file("/#{ file }") do
      it { should exist }
    end
  end

  [
    'docker-api',
    'rspec',
    'rspec_junit_formatter',
    'serverspec',
  ].each do | gem |
    describe package(gem) do
      it { should be_installed.by('gem') }
    end
  end
end

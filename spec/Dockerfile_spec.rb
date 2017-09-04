require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir('.')
    @image.tag(repo: 'jadametz/serverspec', tag: 'latest')

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, @image.id
    set :docker_container_create_options, { 'Entrypoint' => ['ash'] }
  end

  it "should have the maintainer label" do
    expect(@image.json["Config"]["Labels"].has_key?("maintainer"))
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

  it "should execute rspec" do
    expect(@image.json["Config"]["Entrypoint"][0]).to eq("rspec")
  end

  it "should pass the -h option by default" do
    expect(@image.json["Config"]["Cmd"][0]).to eq("-h")
  end
end

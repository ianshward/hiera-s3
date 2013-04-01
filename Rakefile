require 'rubygems'
require 'rubygems/package_task'

spec = Gem::Specification.new do |s|
  s.name = "hiera-s3"
  s.version = "0.0.0"
  s.author = "Ian Ward"
  s.email = "ianshward@gmail.com"
  s.homepage = "https://github.com/ianshward/hiera-s3/"
  s.summary = "S3 backend for the Hiera hierarcical data store"
  s.description = "Store Hiera data in AWS S3"
  s.files = FileList["lib/**/*"].to_a
  s.require_path = "lib"
  s.has_rdoc = true
  s.add_dependency 'aws-sdk'
end

Gem::PackageTask.new(spec) do  |pkg|
  pkg.need_tar = true
end

task :default => [:repackage]

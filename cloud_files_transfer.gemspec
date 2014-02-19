# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_files_transfer/version'

Gem::Specification.new do |spec|
  spec.name          = "cloud_files_transfer"
  spec.version       = CloudFilesTransfer::VERSION
  spec.authors       = ["Mathieu Gagné"]
  spec.email         = ["gagne.mathieu@hotmail.com"]
  spec.description   = %q{Transfer Rackspace Cloud Files assets from one container to another or from account to another.}
  spec.summary       = %q{Transfer Rackspace Cloud Files assets from one container to another or from account to another.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cloudfiles"
end

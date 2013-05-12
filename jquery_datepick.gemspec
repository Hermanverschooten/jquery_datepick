# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jquery_datepick/version'

Gem::Specification.new do |gem|
  gem.name          = "jquery_datepick"
  gem.version       = JqueryDatepick::VERSION
  gem.authors       = ["Herman verschooten"]
  gem.email         = ["Herman@verschooten.net"]
  gem.description   = %q{View helper that allows to select dates from a calendar using jQuery DatePick (http://keith-wood.name/datepick.html)}
  gem.summary       = %q{Gem with helpers for jQuery DatePick (http://keith-wood.name/datepick.html)}
  gem.homepage      = "http://github.com/Hermanverschooten/jquery_datepick"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

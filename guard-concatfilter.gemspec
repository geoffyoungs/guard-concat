# encoding: utf-8
require File.expand_path("../lib/guard/concatfilter", __FILE__)

Gem::Specification.new do |s|
  s.name         = "guard-concatfilter"
  s.authors       = ['Geoff Youngs', "Francesco 'makevoid' Canessa"]
  s.email        = "github@intersect-uk.co.uk"
  s.summary      = "Guard gem for concatenating (js/css) files"
  s.homepage     = "http://github.com/geoffyoungs/guard-concat"
  s.version      = Guard::ConcatFilter::VERSION
  s.licenses      = ['Unspecified'] # XXX: Need to check this?  Original license unspecified

  s.description  = <<-DESC
    Guard::ConcatFilter automatically concatenates files in one when watched files are modified.
  DESC

  s.add_dependency 'guard', '>= 1.1.0'

  s.files        = %w(Readme.md LICENSE)
  s.files       += Dir["{lib}/**/*"]
end

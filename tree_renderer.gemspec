#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require File.expand_path("../lib/tree_renderer/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name = "tree_renderer"
  s.version = TreeRenderer::VERSION
  s.authors = ["Michal Papis"]
  s.email = ["mpapis@gmail.com"]
  s.homepage = "https://github.com/mpapis/tree_renderer"
  s.summary = "Render tree of ERB templates"
  s.license = "Apache 2.0"
  s.files = `git ls-files -z`.split("\0")
  s.test_files = `git ls-files -z -- {test,spec,features}/*`.split("\0")
  s.required_ruby_version = ">= 1.9.3"

  s.add_development_dependency "rake",               "~> 10.0"
  s.add_development_dependency "guard",              "~> 2.0"
  s.add_development_dependency "guard-minitest",     "~> 2.0"
  s.add_development_dependency "minitest",           "~> 4.0"
  s.add_development_dependency "minitest-reporters", "~> 0"
  s.add_development_dependency "simplecov",          "~> 0.11"
  s.add_development_dependency "coveralls",          "~> 0.8"
  s.add_development_dependency "yard",               "~> 0.8"
  # s.add_development_dependency("smf-gem")
end

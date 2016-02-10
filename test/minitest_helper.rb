=begin
Copyright 2016 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

if
  RUBY_VERSION == "2.3.0" # check Gemfile
then
  require "coveralls"
  require "simplecov"

  SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter,
    ]
    command_name "Spesc Tests"
    add_filter "/test/"
  end

  Coveralls.noisy = true unless ENV['CI']
end

require "minitest/autorun"
require "minitest/reporters"
require "tmpdir"
require "pathname"
require "fileutils"

TREE_RENDERER_TMP_DIR = Pathname(Dir.tmpdir).join("tree_renderer")

Dir['lib/**/*.rb'].each { |file| require "./#{file}" } # coverals trick for all files

Minitest::Reporters.use!

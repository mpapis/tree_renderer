=begin
Copyright 2016 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

source "https://rubygems.org"

gemspec

group :development do
  # statistics only on MRI 2.3 - avoid problems on older rubies
  if RUBY_VERSION == "2.3.0"
    gem "redcarpet"
    gem "simplecov"
    gem "coveralls"
  end

  # lower required versions for old ruby
  if RUBY_VERSION == "1.8.7"
    gem "mime-types",  "<2.0.0"
    gem "rest-client", "<1.7.0"
    #gem "listen",      "<2.0.0"
  end

  # do not install guard in CI (save time and avoid endless gem resolution)
  if ENV["CI"] != "true" && RUBY_VERSION != "1.8.7"
    gem "guard",              "~> 2.0"
    gem "guard-minitest",     "~> 2.0"
  end
end

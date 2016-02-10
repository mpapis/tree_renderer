=begin
Copyright 2016 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

source "https://rubygems.org"

gemspec

# statistics only on MRI 2.3 - avoid problems on older rubies
group :development do
  gem "redcarpet"
  gem "simplecov"
  gem "coveralls"
end if RUBY_VERSION == "2.3.0"

if RUBY_VERSION == "1.8.7"
  gem "mime-types", "<2.0.0"
end

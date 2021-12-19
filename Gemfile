# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in jp_local_gov.gemspec
gemspec

gem "rake"

group :development do
  gem "activesupport", "~> 6.1" # TODO: To avoid steep dependencies error. Refs: https://github.com/soutaro/steep/issues/466
  gem "appraisal"
  gem "nokogiri"
  gem "pdf-reader"
  gem "rbs"
  gem "rubocop"
  gem "rubocop-fjord"
  gem "sqlite3"
  gem "steep"
end

group :test do
  gem "rspec"
end

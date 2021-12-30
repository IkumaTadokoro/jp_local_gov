# frozen_string_literal: true

# !/usr/bin/env ruby

# Most of the code here is copied from /lib/appraisal/cli.rb in the appraisal gem library
require "rubygems"
require "bundler/setup"
require "appraisal"
require "appraisal/cli"

begin
  `bundle exec appraisal list`.split(/\R/) do |appraisal_name|
    cmd = [appraisal_name, "rspec"] + ARGV
    Appraisal::CLI.start(cmd)
  end
rescue Appraisal::AppraisalsNotFound => e
  puts e.message
  exit 127
end

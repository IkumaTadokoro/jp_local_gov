# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

require_relative "data/exporter"

namespace :jplocalgov do
  namespace :data do
    desc "Retrieve local_government_code data"
    task :update_all do
      puts "update data and export to json files..."
      JpLocalGov::Data::Exporter.new.execute
      puts "Finish!!"
    end
  end
end

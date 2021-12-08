# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

require_relative "data/importer"
require_relative "data/exporter"

namespace :jplocalgov do
  namespace :data do
    desc "Updates local_government_code data"
    task :update_all do
      puts "Reset temp DB..."
      importer = JpLocalGov::Data::Importer.new
      importer.reset_table

      puts "Retrieving local government data..."
      importer.retrieve_and_save

      puts "Extract to json files..."
      JpLocalGov::Data::Exporter.new.execute
    end
  end
end

# frozen_string_literal: true

require "jp_local_gov"
require "jp_local_gov/base"
require "jp_local_gov/random"
require "active_record"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    setup_db
  end

  config.after(:suite) do
    teardown_db
  end
end

def setup_db
  ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

  ActiveRecord::Schema.define(version: 1) do
    create_table :insurances do |t|
      t.string :local_gov_code
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

# frozen_string_literal: true

require_relative "../jp_local_gov"

module JpLocalGov
  module Random
    DATA_DIR = "#{File.dirname(__FILE__)}/../../data/json/".freeze
    RANDOMIZE_TARGET = %w[code city city_kana prefecture prefecture_code prefecture_kana].freeze

    module_function

    RANDOMIZE_TARGET.each do |target|
      define_method target.to_s do
        sample_data.send(target)
      end
    end

    def sample_data
      file_name = ("1".."47").to_a.sample&.rjust(2, "0")
      json_file = "#{DATA_DIR}#{file_name}.json"
      data = JSON.parse(File.read(json_file), { symbolize_names: true })
      JpLocalGov::LocalGov.new(data[data.keys.sample])
    end

    private_class_method :sample_data
    private_constant :DATA_DIR, :RANDOMIZE_TARGET
  end
end

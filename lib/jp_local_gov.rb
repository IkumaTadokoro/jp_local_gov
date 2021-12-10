# frozen_string_literal: true

require_relative "jp_local_gov/version"
require_relative "jp_local_gov/local_gov"
require "json"

module JpLocalGov
  DATA_DIR = "#{File.dirname(__FILE__)}/../data/json/"
  CHECK_DIGITS_INDEX = 5
  CHECK_BASE = 11

  module_function

  def find(local_gov_code)
    return nil unless local_gov_code.is_a?(String) && valid_code?(local_gov_code)

    json_file = "#{DATA_DIR}#{local_gov_code[0..1]}.json"
    data = JSON.parse(File.open(json_file).read)
    local_gov_data = data[local_gov_code]
    return nil if local_gov_data.nil?

    JpLocalGov::LocalGov.new(local_gov_data)
  end

  # Inspect code by check digits defined in JISX0402
  # https://www.soumu.go.jp/main_content/000137948.pdf
  def valid_code?(code)
    sub_total = code.chars
                    .take(CHECK_DIGITS_INDEX)
                    .map.with_index { |digit, index| digit.to_i * (CHECK_DIGITS_INDEX - index + 1) }
                    .sum
    candidate = (CHECK_BASE - sub_total % CHECK_BASE) % 10
    check_digits = sub_total > CHECK_BASE ? candidate : CHECK_BASE - sub_total
    code[CHECK_DIGITS_INDEX] == check_digits.to_s
  end

  private_class_method :valid_code?
  private_constant :CHECK_DIGITS_INDEX, :CHECK_BASE
end

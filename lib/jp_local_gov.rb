# frozen_string_literal: true

require_relative "jp_local_gov/version"
require_relative "jp_local_gov/local_gov"
require "json"

module JpLocalGov
  JSON_FILE = "#{File.dirname(__FILE__)}/../data/local_gov.json"
  CHECK_DIGITS_INDEX = 5
  CHECK_BASE_NUMBER = 11

  module_function

  def find(local_gov_code)
    return nil if local_gov_code.is_a?(String) && valid_code?(local_gov_code)

    data = JSON.parse(File.open(JSON_FILE).read)
    local_gov_data = data[local_gov_code]
    return nil if local_gov_data.nil?

    JpLocalGov::LocalGov.new(local_gov_data)
  end

  # Inspect code by check digits defined in JISX0402
  # https://www.soumu.go.jp/main_content/000137948.pdf
  def valid_code?(code)
    sub_total = code.chars[0..CHECK_DIGITS_INDEX - 1].map.with_index { |digit, index| digit.to_i * index }.sum
    remainder = (sub_total % CHECK_BASE_NUMBER) % 10
    check_digits = sub_total < CHECK_BASE_NUMBER ? CHECK_BASE_NUMBER - sub_total : remainder
    code[CHECK_DIGITS_INDEX] == check_digits.to_s
  end

  private_class_method :valid_code?
  private_constant :CHECK_DIGITS_INDEX, :CHECK_BASE_NUMBER
end

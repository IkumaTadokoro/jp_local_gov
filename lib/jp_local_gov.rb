# frozen_string_literal: true

require_relative "jp_local_gov/version"
require_relative "jp_local_gov/local_gov"
require_relative "jp_local_gov/base"
require_relative "jp_local_gov/random"
require "json"

module JpLocalGov
  DATA_DIR = "#{File.dirname(__FILE__)}/../data/json/".freeze
  CHECK_DIGITS_INDEX = 5
  CHECK_BASE = 11
  PREFECTURE_RANGE = 1..47
  VALID_CODE_LENGTH = 6

  module_function

  def included(model_class)
    model_class.extend Base
  end

  def find(local_gov_code)
    return nil unless valid_code?(local_gov_code)

    json_file = "#{DATA_DIR}#{local_gov_code[0..1]}.json"
    data = JSON.parse(File.open(json_file).read, { symbolize_names: true })
    local_gov_data = data[local_gov_code.to_sym]
    return nil if local_gov_data.nil?

    JpLocalGov::LocalGov.new(local_gov_data)
  end

  def where(conditions)
    return nil unless conditions.is_a?(Hash)

    json_files = prefecture_code_list.map { "#{DATA_DIR}#{_1}.json" }
    results = json_files.map do |json_file|
      data = JSON.parse(File.read(json_file), { symbolize_names: true })
      build_local_gov(data, conditions)
    end.flatten.compact
    return nil if results.empty?

    results
  end

  # Inspect code by check digits defined in JISX0402
  # https://www.soumu.go.jp/main_content/000137948.pdf
  def valid_code?(code)
    unless code.is_a?(String) && code.length == VALID_CODE_LENGTH && prefecture_code_list.include?(code[0..1])
      return false
    end

    sub_total = code.chars
                    .take(CHECK_DIGITS_INDEX)
                    .map.with_index { |digit, index| digit.to_i * (CHECK_DIGITS_INDEX - index + 1) }
                    .sum
    candidate = (CHECK_BASE - sub_total % CHECK_BASE) % 10
    check_digits = sub_total > CHECK_BASE ? candidate : CHECK_BASE - sub_total
    code[CHECK_DIGITS_INDEX] == check_digits.to_s
  end

  def all
    json_files = prefecture_code_list.map { "#{DATA_DIR}#{_1}.json" }
    json_files.flat_map do |json_file|
      data = JSON.parse(File.read(json_file), { symbolize_names: true })
      data.values.map { |value| JpLocalGov::LocalGov.new(value) }
    end
  end

  def build_local_gov(data, conditions)
    data.values
        .select { |target| filter(target, conditions) }
        .tap { |result| return nil if result.empty? }
        .map { |result| JpLocalGov::LocalGov.new(result) }
  end

  def filter(target, conditions)
    conditions.map { |condition| target[condition[0]] == condition[1] }.all?
  end

  def prefecture_code_list
    [*PREFECTURE_RANGE].map { format("%02<number>d", number: _1) }
  end

  private_class_method :build_local_gov, :filter, :prefecture_code_list
  private_constant :CHECK_DIGITS_INDEX, :CHECK_BASE
end

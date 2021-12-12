# frozen_string_literal: true

require_relative "jp_local_gov/version"
require_relative "jp_local_gov/local_gov"
require "json"

module JpLocalGov
  DATA_DIR = "#{File.dirname(__FILE__)}/../data/json/".freeze
  CHECK_DIGITS_INDEX = 5
  CHECK_BASE = 11

  module_function

  def find(local_gov_code)
    return nil unless local_gov_code.is_a?(String) && valid_code?(local_gov_code)

    json_file = "#{DATA_DIR}#{local_gov_code[0..1]}.json"
    data = JSON.parse(File.open(json_file).read, { symbolize_names: true })
    local_gov_data = data[local_gov_code.to_sym]
    return nil if local_gov_data.nil?

    JpLocalGov::LocalGov.new(local_gov_data)
  end

  def where(conditions)
    return nil unless conditions.is_a?(Hash)

    json_files = [*1..47].map { format("%02<number>d", number: _1) }.map { "#{DATA_DIR}#{_1}.json" }
    results = json_files.map do |json_file|
      data = JSON.parse(File.open(json_file).read, { symbolize_names: true })
      build_local_gov(data, conditions)
    end.flatten.compact
    return nil if results.empty?

    results.one? ? results.first : results
  end

  def build_local_gov(data, conditions)
    data.values
        .select { |target| query_builder(target, conditions) }
        .tap { |result| return nil if result.empty? }
        .map { |result| JpLocalGov::LocalGov.new(result) }
  end

  def query_builder(target, conditions)
    condition_stmt = conditions.map.with_index do |condition, index|
      value = condition[1].is_a?(String) ? "\"#{condition[1]}\"" : (condition[1]).to_s
      template = "#{target}[:#{condition[0]}] == #{value}"
      index.zero? ? template : " && #{template}"
    end.join
    eval condition_stmt
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

  private_class_method :valid_code?, :build_local_gov, :query_builder
  private_constant :CHECK_DIGITS_INDEX, :CHECK_BASE
end

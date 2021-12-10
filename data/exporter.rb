# frozen_string_literal: true

require "json"
require_relative "base"

module JpLocalGov
  module Data
    class Exporter
      SELECT_SQL = <<-SQL
        SELECT
          code,
          prefecture_code,
          prefecture,
          prefecture_kana,
          city,
          city_kana,
          prefecture_capital
        FROM local_governments
        ORDER BY code
      SQL

      def initialize
        @db = JpLocalGov::Data::Base.new.db
      end

      def execute
        local_governments.each do |prefix, value|
          file_path = File.expand_path("../../data/json/#{prefix}.json", __FILE__)
          File.open(file_path, "wb") do |file|
            file.write JSON.pretty_generate(value)
          end
        end
      end

      private

      def local_governments
        local_governments = {}

        @db.execute(SELECT_SQL) do |row|
          lg_hash = to_hash(row)
          local_governments[lg_hash[:prefecture_code]] ||= {}
          local_governments[lg_hash[:prefecture_code]] =
            local_governments[lg_hash[:prefecture_code]].merge(lg_hash[:code] => lg_hash)
        end

        local_governments
      end

      def to_hash(row)
        local_government = {}
        local_government[:code],
        local_government[:prefecture_code],
        local_government[:prefecture],
        local_government[:prefecture_kana],
        local_government[:city],
        local_government[:city_kana],
        local_government[:prefecture_capital] = row

        local_government[:prefecture_capital] = local_government[:prefecture_capital] == "1"
        local_government
      end
    end
  end
end

# frozen_string_literal: true

require "open-uri"
require "pdf-reader"
require "json"
require "nokogiri"

module JpLocalGov
  module Data
    class Exporter
      URL_DOMAIN = "https://www.soumu.go.jp"
      SEARCH_URL = "https://www.soumu.go.jp/denshijiti/code.html"
      JSON_FILE = "local_gov.json"
      VALID_COLUMN_COUNT = 5

      def initialize
        @local_gov_hash = Hash.new { |h, k| h[k] = {} }
      end

      def execute
        retrieve_data
        set_prefecture_capital
        output_json
      end

      private

      def retrieve_data
        reader = PDF::Reader.new(OpenURI.open_uri(pdf_url))

        reader.pages.each do |page|
          page.text.split("\n").each do |row|
            items = row.split("\s")
            next if header?(items) || items.length != VALID_COLUMN_COUNT

            to_hash(items)
          end
        end
      end

      def to_hash(items)
        @local_gov_hash[items[0]] = {
          code: items[0],
          prefecture_code: items[1][0..1],
          prefecture: items[1],
          prefecture_kana: covert_half_char_to_full_char(items[3]),
          city: items[2],
          city_kana: covert_half_char_to_full_char(items[4]),
          prefecture_capital: false
        }
      end

      def set_prefecture_capital
        prefecture_capital_list = JSON.parse(File.open(File.expand_path("prefecture_capital.json", __dir__)).read)

        prefecture_capital_list.each do |row|
          city = @local_gov_hash.values.find { |lg| lg[:prefecture] == row["prefecture"] && lg[:city] == row["city"] }
          city[:prefecture_capital] = true
        end
      end

      def output_json
        file_path = File.expand_path("../../data/local_gov.json", __FILE__)
        File.open(file_path, "w") do |file|
          file.write JSON.pretty_generate(@local_gov_hash)
        end
      end

      def pdf_url
        html = Nokogiri::HTML(OpenURI.open_uri(SEARCH_URL))
        url = html.css('[href$=".pdf"]').first.attributes["href"]
        "#{URL_DOMAIN}#{url}"
      end

      def header?(row)
        (row[0] =~ /[0-9]/).nil?
      end

      def covert_half_char_to_full_char(text)
        text.gsub(/[\uFF61-\uFF9F]+/) { |str| str.unicode_normalize(:nfkc) }
      end
    end
  end
end

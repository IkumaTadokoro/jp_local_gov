# frozen_string_literal: true

require_relative "base"
require "open-uri"
require "pdf-reader"
require "json"
require "nokogiri"

module JpLocalGov
  module Data
    class Importer < Base
      private

      URL_DOMAIN = "https://www.soumu.go.jp"
      SEARCH_URL = "https://www.soumu.go.jp/denshijiti/code.html"
      VALID_COLUMN_COUNT = 5

      def retrieve
        local_governments = []
        PDF::Reader.new(OpenURI.open_uri(pdf_url)).pages.each do |page|
          page.text.split("\n").each do |row|
            items = row.split("\s")
            next if header?(items) || items.length != VALID_COLUMN_COUNT

            local_governments << to_hash(items)
          end
        end
        local_governments.uniq # to exclude special areas header(ex: Hokkaido Sapporo)
      end

      def to_hash(items)
        {
          code: items[0],
          prefecture_code: items[0][0..1],
          prefecture: items[1],
          prefecture_kana: covert_half_char_to_full_char(items[3]),
          city: items[2],
          city_kana: covert_half_char_to_full_char(items[4]),
          prefecture_capital: prefecture_capital?(items[1], items[2]) ? 1 : 0
        }
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

      def prefecture_capital?(prefecture, city)
        prefecture_capital_list = JSON.parse(File.open(File.expand_path("prefecture_capital.json", __dir__)).read)
        prefecture_capital_list.any? do |prefecture_capital|
          prefecture_capital["prefecture"] == prefecture && prefecture_capital["city"] == city
        end
      end
    end
  end
end

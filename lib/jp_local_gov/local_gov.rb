# frozen_string_literal: true

module JpLocalGov
  class LocalGov
    attr_reader :code, :prefecture_code, :prefecture, :prefecture_kana, :city, :city_kana, :prefecture_capital

    def initialize(data)
      @code = data[:code]
      @prefecture_code = data[:prefecture_code]
      @prefecture = data[:prefecture]
      @prefecture_kana = data[:prefecture_kana]
      @city = data[:city]
      @city_kana = data[:city_kana]
      @prefecture_capital = data[:prefecture_capital]
    end
  end
end

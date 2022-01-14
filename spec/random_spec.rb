# frozen_string_literal: true

RSpec.describe JpLocalGov::Random do
  describe ".code" do
    let!(:code) { JpLocalGov::Random.code }
    it "returns valid random code" do
      expect(code).to be_a_kind_of String
      expect(JpLocalGov.valid_code?(code)).to be_truthy
    end
  end

  describe ".city" do
    let!(:city) { JpLocalGov::Random.city }
    it "returns existing city name " do
      expect(city).to be_a_kind_of String
      expect(JpLocalGov.where(city: city).map(&:city)).to include city
    end
  end

  describe ".city_kana" do
    let!(:city_kana) { JpLocalGov::Random.city_kana }
    it "returns existing city name(kana)" do
      expect(city_kana).to be_a_kind_of String
      expect(JpLocalGov.where(city_kana: city_kana).map(&:city_kana)).to include city_kana
    end
  end

  describe ".prefecture_code" do
    let!(:prefecture_code) { JpLocalGov::Random.prefecture_code }
    it "returns existing prefecture_code" do
      expect(prefecture_code).to be_a_kind_of String
      expect(JpLocalGov.where(prefecture_code: prefecture_code).map(&:prefecture_code)).to include prefecture_code
    end
  end

  describe ".prefecture" do
    let!(:prefecture) { JpLocalGov::Random.prefecture }
    it "returns existing prefecture" do
      expect(prefecture).to be_a_kind_of String
      expect(JpLocalGov.where(prefecture: prefecture).map(&:prefecture)).to include prefecture
    end
  end

  describe ".prefecture_kana" do
    let!(:prefecture_kana) { JpLocalGov::Random.prefecture_kana }
    it "returns existing prefecture_kana" do
      expect(prefecture_kana).to be_a_kind_of String
      expect(JpLocalGov.where(prefecture_kana: prefecture_kana).map(&:prefecture_kana)).to include prefecture_kana
    end
  end
end

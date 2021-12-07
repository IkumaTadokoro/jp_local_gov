# frozen_string_literal: true

RSpec.describe JpLocalGov do
  describe ".find" do
    context "the local government code is specified" do
      subject(:result) { JpLocalGov.find(local_gov_code) }

      context "when the code exists" do
        let(:local_gov_code) { "131016" }
        it "returns a single LocalGov record" do
          expect(result.code).to eq("131016")
          expect(result.prefecture_code).to eq("13")
          expect(result.prefecture).to eq("東京都")
          expect(result.prefecture_kana).to eq("トウキョウト")
          expect(result.city).to eq("千代田区")
          expect(result.city_kana).to eq("チヨダク")
          expect(result.prefecture_capital).to be_falsey
        end
      end

      context "when the code DOES NOT exist" do
        context "when the code is NOT existing code" do
          # NOT existing code is able to generate by check digit defined in JISX0402
          # https://www.soumu.go.jp/main_content/000137948.pdf
          let(:local_gov_code) { "131017" }
          it { is_expected.to be_nil }
        end

        context "when the code is nil" do
          let(:local_gov_code) { nil }
          it { is_expected.to be_nil }
        end

        context "when the code is NOT a string" do
          let(:local_gov_code) { 131016 }
          it { is_expected.to be_nil }
        end
      end
    end
  end
end

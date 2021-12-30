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
          let(:local_gov_code) { 131_016 }
          it { is_expected.to be_nil }
        end
      end
    end
  end

  describe ".where" do
    context "only one condition is specified" do
      subject(:result) { JpLocalGov.where(condition) }

      context "when the only one result exists" do
        let(:condition) { { city: "千代田区" } }
        it "returns Array includes only one LocalGov record" do
          expect(result).to be_a_kind_of(Array)
          expect(result[0].code).to eq("131016")
          expect(result[0].prefecture_code).to eq("13")
          expect(result[0].prefecture).to eq("東京都")
          expect(result[0].prefecture_kana).to eq("トウキョウト")
          expect(result[0].city).to eq("千代田区")
          expect(result[0].city_kana).to eq("チヨダク")
          expect(result[0].prefecture_capital).to be_falsey
        end
      end

      context "when the several results exist" do
        let(:condition) { { city: "森町" } }
        it "returns Array includes several LocalGov record" do
          expect(result).to be_a_kind_of(Array)
          expect(result[0].code).to eq("013455")
          expect(result[0].prefecture_code).to eq("01")
          expect(result[0].prefecture).to eq("北海道")
          expect(result[0].prefecture_kana).to eq("ホッカイドウ")
          expect(result[0].city).to eq("森町")
          expect(result[0].city_kana).to eq("モリマチ")
          expect(result[0].prefecture_capital).to be_falsey
          expect(result[1].code).to eq("224618")
          expect(result[1].prefecture_code).to eq("22")
          expect(result[1].prefecture).to eq("静岡県")
          expect(result[1].prefecture_kana).to eq("シズオカケン")
          expect(result[1].city).to eq("森町")
          expect(result[1].city_kana).to eq("モリマチ")
          expect(result[1].prefecture_capital).to be_falsey
        end
      end

      context "when the result DOES NOT exist" do
        context "when the condition is NOT match any local governments" do
          let(:condition) { { prefecture: "東京府" } }
          it { is_expected.to be_nil }
        end

        context "when the condition is nil" do
          let(:condition) { nil }
          it { is_expected.to be_nil }
        end

        context "when the condition is NOT a hash" do
          let(:condition) { "prefecture: 東京都" }
          it { is_expected.to be_nil }
        end
      end
    end

    context "multiple conditions are specified" do
      subject(:result) { JpLocalGov.where(condition) }
      context "when the only one result exists" do
        let(:condition) { { prefecture: "東京都", prefecture_capital: true } }
        it "returns Array includes only one LocalGov record" do
          expect(result).to be_a_kind_of(Array)
          expect(result[0].code).to eq("131041")
          expect(result[0].prefecture_code).to eq("13")
          expect(result[0].prefecture).to eq("東京都")
          expect(result[0].prefecture_kana).to eq("トウキョウト")
          expect(result[0].city).to eq("新宿区")
          expect(result[0].city_kana).to eq("シンジュクク")
          expect(result[0].prefecture_capital).to be_truthy
        end
      end

      context "when the several results exist" do
        let(:condition) { { city: "森町", city_kana: "モリマチ" } }
        it "returns Array includes several LocalGov record" do
          expect(result).to be_a_kind_of(Array)
          expect(result[0].code).to eq("013455")
          expect(result[0].prefecture_code).to eq("01")
          expect(result[0].prefecture).to eq("北海道")
          expect(result[0].prefecture_kana).to eq("ホッカイドウ")
          expect(result[0].city).to eq("森町")
          expect(result[0].city_kana).to eq("モリマチ")
          expect(result[0].prefecture_capital).to be_falsey
          expect(result[1].code).to eq("224618")
          expect(result[1].prefecture_code).to eq("22")
          expect(result[1].prefecture).to eq("静岡県")
          expect(result[1].prefecture_kana).to eq("シズオカケン")
          expect(result[1].city).to eq("森町")
          expect(result[1].city_kana).to eq("モリマチ")
          expect(result[1].prefecture_capital).to be_falsey
        end
      end

      context "when the result DOES NOT exist" do
        context "when the condition is NOT match any local governments" do
          let(:condition) { { city: "千代田区", prefecture_capital: true } }
          it { is_expected.to be_nil }
        end
      end
    end
  end

  describe "#valid_code?" do
    subject(:result) { JpLocalGov.valid_code?(code) }

    context "when the valid local_gov_code is specified" do
      let(:code) { "011002" }
      it { is_expected.to be_truthy }
    end

    context "when the INVALID local_gov_code is specified" do
      context "when the code format is valid" do
        context "when the code starts with 01-47" do
          let(:code) { "011003" }
          it { is_expected.to be_falsey }
        end

        context "when the code DOES NOT start with 01-47" do
          let(:code) { "481238" }
          it { is_expected.to be_falsey }
        end
      end

      context "when the code format is INVALID" do
        context "when the code is not String(Integer)" do
          let(:code) { 011_002 }
          it { is_expected.to be_falsey }
        end

        context "when the code length is not 6" do
          context "when the code length is over 6" do
            let(:code) { "0110022" }
            it { is_expected.to be_falsey }
          end

          context "when the code length is under 6" do
            let(:code) { "01100" }
            it { is_expected.to be_falsey }
          end
        end
      end
    end
  end
end

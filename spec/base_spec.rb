# frozen_string_literal: true

RSpec.describe JpLocalGov::Base do
  describe "#jp_local_gov" do
    describe "argument :column_name" do
      context "when the column_name specified" do
        let(:model_class) do
          klass = Class.new(ActiveRecord::Base) do
            self.table_name = :insurances
            include JpLocalGov
            jp_local_gov :local_gov_code
          end
          klass.new(local_gov_code: "131016")
        end

        it "be able to convert local_gov_code" do
          expect(model_class.local_government.city).to eq "千代田区"
        end
      end
    end

    describe "return value" do
      let(:klass) do
        Class.new(ActiveRecord::Base) do
          self.table_name = :insurances
          include JpLocalGov
          jp_local_gov :local_gov_code
        end
      end

      context "when the code exists" do
        let(:model_class) { klass.new(local_gov_code: "131016") }
        it { expect(model_class).to respond_to(:local_government) }
        it { expect(model_class.local_government).to be_an_instance_of(JpLocalGov::LocalGov) }
        it { expect(model_class.local_government.city).to eq "千代田区" }
      end

      context "when the code DOES NOT exist" do
        let(:model_class) { klass.new(local_gov_code: "131017") }
        it { expect(model_class).to respond_to(:local_government) }
        it { expect(model_class.local_government).to be_nil }
      end
    end
  end
end

# frozen_string_literal: true

require_relative "../jp_local_gov"

module JpLocalGov
  module Base
    def jp_local_gov(column_name)
      define_method "local_government" do
        JpLocalGov.find(send(column_name))
      end
    end
  end
end

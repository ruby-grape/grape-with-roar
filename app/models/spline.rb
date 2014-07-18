module Acme
  module Models
    class Spline
      include ActiveModel::Model

      attr_accessor :uuid
      attr_accessor :reticulated

      def initialize(attrs = {})
        super(attrs)
        @uuid ||= SecureRandom.uuid
        @reticulated = [true, false].sample
      end
    end
  end
end

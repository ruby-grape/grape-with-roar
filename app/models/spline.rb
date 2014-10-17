module Acme
  module Models
    class Spline
      include ActiveModel::Model

      attr_accessor :uuid
      attr_accessor :reticulated

      def initialize(attrs = { reticulated: [true, false].sample })
        super(attrs)
        @uuid ||= SecureRandom.uuid
        @reticulated = !!attrs[:reticulated]
      end
    end
  end
end

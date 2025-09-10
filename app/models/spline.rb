module Acme
  module Models
    class Spline
      include ActiveModel::Model

      attr_accessor :uuid, :reticulated

      def initialize(attrs = { reticulated: [true, false].sample })
        super
        @uuid ||= SecureRandom.uuid
        @reticulated = !!attrs[:reticulated]
      end

      def self.all
        Array.new(42) { Acme::Models::Spline.new }
      end

      def self.find(uuid)
        Acme::Models::Spline.new(uuid: uuid)
      end

      def save!; end

      def destroy; end
    end
  end
end

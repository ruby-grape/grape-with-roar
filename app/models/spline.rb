module Acme
  module Models
    class Spline
      include Mongoid::Document

      field :name, type: String
      field :reticulated, type: Boolean, default: false
    end
  end
end

module Acme
  module Models
    class Spline < ActiveRecord::Base
      attr_accessible :name, :reticulated
    end
  end
end

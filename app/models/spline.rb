module Acme
  module Models
    class Spline < ActiveRecord::Base
      attr_accessor :name, :reticulated
    end
  end
end

module Grape
  module Extensions
    module CrudExtension
      def create(type, options = {})
        instance = type.create! options[:from]
        present instance, with: options[:with]
      end

      def update(instance, options = {})
        instance.update_attributes! options[:from]
        present instance, with: options[:with]
      end

      def delete(instance, options = {})
        instance.destroy
        present instance, with: options[:with]
      end

      Grape::Endpoint.send(:include, self)
    end
  end
end

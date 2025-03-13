# frozen_string_literal: true

module Mutations
  module Product
    class CreateProductMutation < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :description, String, required: false
      argument :category, ID, required: true, prepare: ->(category, _) { ::Category.find(category) }

      type Types::ProductType

      def resolve(name:, category:, description: nil)
        ::Product.create!(name: name, description:description, category: category)
      end
    end
  end
end

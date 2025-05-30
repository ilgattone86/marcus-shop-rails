# frozen_string_literal: true

module Mutations
  module Product
    class EditProductMutation < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :description, String, required: false
      argument :parts, [ ID ], required: true, prepare: ->(parts, _) { ::Part.find(parts) }
      argument :product, ID, required: true, prepare: ->(product, _) { ::Product.find(product) }
      argument :category, ID, required: true, prepare: ->(category, _) { ::Category.find(category) }

      type Types::ProductType

      def resolve(product:, name:, category:, parts:, description: nil)
        product.update!(name: name, description: description, category: category, parts: parts)

        product
      end
    end
  end
end

# frozen_string_literal: true

module Mutations
  module Product
    class DeleteProductMutation < ::Mutations::BaseMutation
      argument :product, ID, required: true, prepare: ->(product, _) { ::Product.find(product) }

      type Types::ProductType

      def resolve(product:)
        product.soft_delete

        product
      end
    end
  end
end

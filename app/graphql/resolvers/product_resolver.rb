# frozen_string_literal: true

module Resolvers
  class ProductResolver < ::Resolvers::BaseResolver
    argument :product_id, ID, required: true

    type Types::ProductType, null: false
    def resolve(product_id:)
      ::Product.find(product_id)
    end
  end
end

# frozen_string_literal: true

module Resolvers
  class ProductResolver < ::Resolvers::BaseResolver
    argument :product, ID, required: true, prepare: ->(product, _) { ::Product.find(product) }

    type Types::ProductType, null: false
    def resolve(product:)
      product
    end
  end
end

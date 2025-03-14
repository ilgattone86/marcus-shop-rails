# frozen_string_literal: true

module Resolvers
  class ProductsResolver < ::Resolvers::BaseResolver
    type [ Types::ProductType ], null: false

    def resolve
      ::Product.not_deleted.includes(:category)
    end
  end
end

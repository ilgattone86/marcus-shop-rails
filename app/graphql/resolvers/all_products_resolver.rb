# frozen_string_literal: true

module Resolvers
  class AllProductsResolver < ::Resolvers::BaseResolver
    type [ Types::ProductType ], null: false

    def resolve
      ::Product.not_deleted
    end
  end
end

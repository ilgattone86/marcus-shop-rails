# frozen_string_literal: true

module Resolvers
  class ProductsResolver < ::Resolvers::BaseResolver
    type Types::ProductType.connection_type, null: false

    def resolve
      ::Product.all.includes(:category)
    end
  end
end

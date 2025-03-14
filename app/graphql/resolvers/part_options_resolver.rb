# frozen_string_literal: true

module Resolvers
  class PartOptionsResolver < ::Resolvers::BaseResolver
    argument :product, ID, required: false, prepare: ->(product, _) { ::Product.find(product) }
    argument :only_in_stock, Boolean, required: false

    type [ Types::PartOptionType ], null: false

    def resolve(product: nil, only_in_stock: nil)
      ::PartOption.not_deleted
                  .filter_for_product(product)
                  .filter_for_stock(only_in_stock)
                  .includes(:part)
    end
  end
end

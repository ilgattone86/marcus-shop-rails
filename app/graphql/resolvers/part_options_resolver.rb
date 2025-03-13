# frozen_string_literal: true

module Resolvers
  class PartOptionsResolver < ::Resolvers::BaseResolver
    argument :product_id, ID, required: false

    type [ Types::PartOptionType ], null: false

    def resolve(product_id: nil)
      ::PartOption.not_deleted.filter_for_product(product_id).includes(:part)
    end
  end
end

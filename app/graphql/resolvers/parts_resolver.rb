# frozen_string_literal: true

module Resolvers
  class PartsResolver < ::Resolvers::BaseResolver
    argument :product_id, ID, required: false

    type [ Types::PartType ], null: false
    def resolve(product_id: nil)
      ::Part.not_deleted.filter_for_product(product_id).distinct
    end
  end
end

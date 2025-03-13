# frozen_string_literal: true

module Resolvers
  class RestrictionsResolver < ::Resolvers::BaseResolver
    argument :part_option, ID, required: false, prepare: ->(part_option, _) { ::PartOption.find(part_option) }

    type [ Types::RestrictionType ], null: false

    def resolve(part_option: nil)
      ::Restriction.filter_for_dependent_option(part_option)
    end
  end
end

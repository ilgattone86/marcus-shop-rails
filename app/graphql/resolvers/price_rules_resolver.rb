# frozen_string_literal: true

module Resolvers
  class PriceRulesResolver < ::Resolvers::BaseResolver
    type [ Types::PriceRuleType ], null: false

    def resolve
      ::PriceRule.all
    end
  end
end

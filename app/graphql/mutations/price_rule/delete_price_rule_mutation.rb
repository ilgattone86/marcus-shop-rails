# frozen_string_literal: true

module Mutations
  module PriceRule
    class DeletePriceRuleMutation < ::Mutations::BaseMutation
      argument :price_rule, ID, required: true, prepare: ->(price_rule, _) { ::PriceRule.find(price_rule) }

      type ::Types::PriceRuleType

      def resolve(price_rule:)
        price_rule.destroy

        price_rule
      end
    end
  end
end

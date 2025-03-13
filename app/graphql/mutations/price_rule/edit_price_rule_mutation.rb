# frozen_string_literal: true

module Mutations
  module PriceRule
    class EditPriceRuleMutation < ::Mutations::BaseMutation
      argument :price_adjustment, Float, required: true
      argument :price_rule, ID, required: true, prepare: ->(price_rule, _) { ::PriceRule.find(price_rule) }
      argument :base_option, ID, required: true, prepare: ->(base_option, _) { ::PartOption.find(base_option) }
      argument :dependent_option, ID, required: true, prepare: ->(dependent_option, _) { ::PartOption.find(dependent_option) }

      type Types::PriceRuleType

      def resolve(price_rule:, price_adjustment:, base_option:, dependent_option:)
        price_rule.update!(base_option: base_option,
                           price_adjustment: price_adjustment,
                           dependent_option: dependent_option)

        price_rule
      end
    end
  end
end

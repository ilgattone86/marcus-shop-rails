# frozen_string_literal: true

module Mutations
  module PriceRule
    class CreatePriceRuleMutation < ::Mutations::BaseMutation
      argument :price_adjustment, Float, required: true
      argument :base_option, ID, required: true, prepare: ->(base_option, _) { ::PartOption.find(base_option) }
      argument :dependent_option, ID, required: true, prepare: ->(dependent_option, _) { ::PartOption.find(dependent_option) }

      type ::Types::PriceRuleType

      def resolve(price_adjustment:, base_option:, dependent_option:)
        ::PriceRule.create!(base_option: base_option,
                            dependent_option: dependent_option,
                            price_adjustment: price_adjustment)
      end
    end
  end
end

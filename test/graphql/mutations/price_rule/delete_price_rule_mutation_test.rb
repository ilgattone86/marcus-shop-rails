require "test_helper"

module Mutations
  module PriceRule
    class DeletePriceRuleResolverTest < ActiveSupport::TestCase
      test "should delete a price rule" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($priceRule: ID!) {
            deletePriceRule(priceRule: $priceRule) {
              id
            }
          }
        GRAPHQL

        price_rule = price_rules(:first_price_rule)

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { priceRule: price_rule.id })
        price_rule_exists = ::PriceRule.find_by(id: price_rule.id)

        ### Then
        assert_nil(price_rule_exists)
      end
    end
  end
end

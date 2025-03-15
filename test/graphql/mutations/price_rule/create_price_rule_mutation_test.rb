require "test_helper"

module Mutations
  module PriceRule
    class CreatePriceRuleResolverTest < ActiveSupport::TestCase
      test "should create a price rule" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($priceAdjustment: Float!, $baseOption: ID!, $dependentOption: ID!) {
            createPriceRule(priceAdjustment: $priceAdjustment, baseOption: $baseOption, dependentOption: $dependentOption) {
              id
              priceAdjustment
              baseOption {
                id
              }
              dependentOption {
                id
              }
            }
          }
        GRAPHQL

        price_adjustment = 100
        road_wheels = part_options(:road_wheels)
        eight_speed_chain = part_options(:eight_speed_chain)

        variables = { baseOption: road_wheels.id,
                      priceAdjustment: price_adjustment,
                      dependentOption: eight_speed_chain.id }

        price_rules_before = ::PriceRule.count

        ### When
        new_rule = MarcusShopSchema.execute(mutation_string, variables: variables).dig("data", "createPriceRule")
        price_rules_after = ::PriceRule.count

        ### Then
        assert_not_nil(new_rule)
        assert_equal(price_rules_after, price_rules_before + 1)
        assert_equal(new_rule.dig("priceAdjustment"), price_adjustment)
        assert_equal(new_rule.dig("baseOption", "id").to_s, road_wheels.id.to_s)
        assert_equal(new_rule.dig("dependentOption", "id"), eight_speed_chain.id.to_s)
      end
    end
  end
end

require "test_helper"

module Mutations
  module PriceRule
    class EditPriceRuleResolverTest < ActiveSupport::TestCase
      test "should edit a part option" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($priceRule: ID!, $priceAdjustment: Float!, $baseOption: ID!, $dependentOption: ID!) {
            editPriceRule(priceRule: $priceRule, priceAdjustment: $priceAdjustment, baseOption: $baseOption, dependentOption: $dependentOption) {
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

        price_rule = price_rules(:first_price_rule)

        road_wheels = part_options(:road_wheels)
        eight_speed_chain = part_options(:eight_speed_chain)

        new_price_adjustment = rand(100..1000)
        new_base = eight_speed_chain.id
        new_dependent = road_wheels.id

        variables = { priceRule: price_rule.id,
                      priceAdjustment: new_price_adjustment,
                      baseOption: new_base,
                      dependentOption: new_dependent }

        ### When
        edited_price_rule_result = MarcusShopSchema.execute(mutation_string, variables: variables)
        edited_price_rule = edited_price_rule_result.dig("data", "editPriceRule")

        price_rule.reload

        ### Then
        assert_equal(price_rule.price_adjustment, edited_price_rule["priceAdjustment"])
        assert_equal(price_rule.base_option_id.to_s, edited_price_rule.dig("baseOption", "id").to_s)
        assert_equal(price_rule.dependent_option_id.to_s, edited_price_rule.dig("dependentOption", "id").to_s)
      end
    end
  end
end

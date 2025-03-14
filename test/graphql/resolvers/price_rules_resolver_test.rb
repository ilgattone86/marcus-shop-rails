require "test_helper"

module Resolvers
  class PriceRulesResolverTest < ActiveSupport::TestCase
    query_string = <<-GRAPHQL
      query {
        priceRules {
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

    test "should return the price rules" do
      ### When
      price_rules = MarcusShopSchema.execute(query_string).dig("data", "priceRules")

      ### Then
      assert_not_empty(price_rules)
    end
  end
end

require "test_helper"

module Resolvers
  class RestrictionsResolverTest < ActiveSupport::TestCase
    query_string = <<-GRAPHQL
      query($partOption: ID) {
        restrictions(partOption: $partOption) {
          id
          blockedOption {
            id
          }
          dependentOption {
            id
          }
        }
      }
    GRAPHQL

    test "should return the restriction" do
      ### When
      restrictions = MarcusShopSchema.execute(query_string).dig("data", "restrictions")

      ### Then
      assert_not_empty(restrictions)
    end

    test "should return only restrictions of the specific part option" do
      ### Given
      first_restriction = restrictions(:first_restriction)
      dependent_part_option_id = first_restriction.dependent_option_id
      blocked_part_option_id = first_restriction.blocked_option_id

      ### When
      restrictions_result = MarcusShopSchema.execute(query_string, variables: { partOption: dependent_part_option_id })
      restrictions = restrictions_result.dig("data", "restrictions").map do |user_permission|
        [ user_permission.dig("dependentOption", "id"), user_permission.dig("blockedOption", "id") ]
      end

      ### Then
      assert_not_empty(restrictions)
      assert_equal(restrictions.length, 1)
      assert_equal([ dependent_part_option_id.to_s, blocked_part_option_id.to_s ], restrictions[0])
    end
  end
end

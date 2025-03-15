require "test_helper"

module Mutations
  module Restriction
    class EditRestrictionResolverTest < ActiveSupport::TestCase
      test "should edit a restriction" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($restriction: ID!, $dependentOption: ID!, $blockedOption: ID!) {
            editRestriction(restriction: $restriction, dependentOption: $dependentOption, blockedOption: $blockedOption) {
              id
              dependentOption {
                id
              }
              blockedOption {
                id
              }
            }
          }
        GRAPHQL

        restriction = restrictions(:first_restriction)

        mountain_wheels = part_options(:mountain_wheels)
        single_speed_chain = part_options(:single_speed_chain)

        variables = { restriction: restriction.id,
                      dependentOption: mountain_wheels.id,
                      blockedOption: single_speed_chain.id }

        ### When
        edited_restriction_result = MarcusShopSchema.execute(mutation_string, variables: variables)
        edited_restriction = edited_restriction_result.dig("data", "editRestriction")
        restriction.reload

        ### Then
        assert_equal(restriction.id.to_s, edited_restriction.dig("id"))
        assert_equal(restriction.blocked_option_id.to_s, edited_restriction.dig("blockedOption", "id"))
        assert_equal(restriction.dependent_option_id.to_s, edited_restriction.dig("dependentOption", "id"))
      end
    end
  end
end

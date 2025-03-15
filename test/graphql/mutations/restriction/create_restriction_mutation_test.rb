require "test_helper"

module Mutations
  module Restriction
    class CreateRestrictionResolverTest < ActiveSupport::TestCase
      mutation_string = <<-GRAPHQL
        mutation($dependentOption: ID!, $blockedOption: ID!) {
          createRestriction(dependentOption: $dependentOption, blockedOption: $blockedOption) {
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

      test "should create a restriction" do
        ### Given
        ::Restriction.destroy_all

        eight_speed_chain = part_options(:eight_speed_chain)
        road_wheels = part_options(:road_wheels)

        variables = { dependentOption: eight_speed_chain.id, blockedOption: road_wheels.id }

        restrictions_before = ::Restriction.count

        ### When
        new_restriction = MarcusShopSchema.execute(mutation_string, variables: variables).dig("data", "createRestriction")
        restrictions_after = ::Restriction.count

        ### Then
        assert_not_nil(new_restriction)
        assert_equal(restrictions_after, restrictions_before + 1)
        assert_equal(new_restriction.dig("blockedOption", "id"), road_wheels.id.to_s)
        assert_equal(new_restriction.dig("dependentOption", "id"), eight_speed_chain.id.to_s)
      end
      test "should return an error if you try to create a restriction that already exists between two options" do
        ### Given
        restriction = restrictions(:first_restriction)

        blocked_option = restriction.blocked_option_id
        dependent_option = restriction.dependent_option_id

        variables = { dependentOption: blocked_option, blockedOption: dependent_option }

        restrictions_before = ::Restriction.count

        ### Then
        assert_raise ActiveRecord::RecordInvalid do
          ### When
          MarcusShopSchema.execute(mutation_string, variables: variables)
        end
        restrictions_after = ::Restriction.count
        assert_equal(restrictions_before, restrictions_after)
      end
    end
  end
end

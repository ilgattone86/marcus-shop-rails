require "test_helper"

module Mutations
  module Restriction
    class DeleteRestrictionResolverTest < ActiveSupport::TestCase
      test "should delete a restriction" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($restriction: ID!) {
            deleteRestriction(restriction: $restriction) {
              id
            }
          }
        GRAPHQL

        restriction = restrictions(:first_restriction)

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { restriction: restriction.id })
        restriction_exists = ::Restriction.find_by(id: restriction.id)

        ### Then
        assert_nil(restriction_exists)
      end
    end
  end
end

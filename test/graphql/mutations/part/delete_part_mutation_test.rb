require "test_helper"

module Mutations
  module Part
    class DeletePartResolverTest < ActiveSupport::TestCase
      test "should soft delete a part" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($part: ID!) {
            deletePart(part: $part) {
              id
              name
            }
          }
        GRAPHQL

        wheels = parts(:wheels)

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { part: wheels.id })
        wheels.reload

        ### Then
        assert_not_nil(wheels.deleted_at)
      end
    end
  end
end

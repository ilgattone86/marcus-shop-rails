require "test_helper"

module Mutations
  module Part
    class EditPartResolverTest < ActiveSupport::TestCase
      test "should edit a part" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($part: ID!, $name: String!) {
            editPart(part: $part, name: $name) {
              id
              name
            }
          }
        GRAPHQL

        wheels = parts(:wheels)
        name_before = wheels.name

        new_name = "foo"

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { part: wheels.id, name: new_name })
        wheels.reload

        ### Then
        assert_not_equal(wheels.name, name_before)
      end
    end
  end
end

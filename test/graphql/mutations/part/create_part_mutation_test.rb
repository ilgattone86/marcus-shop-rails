require "test_helper"

module Mutations
  module Part
    class CreatePartResolverTest < ActiveSupport::TestCase
      test "should create a part" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($name: String!) {
            createPart(name: $name) {
              id
              name
            }
          }
        GRAPHQL

        name = "foo"
        parts_before = ::Part.count

        ### When
        new_part = MarcusShopSchema.execute(mutation_string, variables: { name: name }).dig("data", "createPart")
        parts_after = ::Part.count

        ### Then
        assert_not_nil(new_part)
        assert_equal(parts_after, parts_before + 1)
        assert_equal(new_part.dig("name"), name)
      end
    end
  end
end

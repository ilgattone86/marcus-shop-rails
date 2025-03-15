require "test_helper"

module Mutations
  module Category
    class EditCategoryResolverTest < ActiveSupport::TestCase
      test "should edit a category" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($category: ID!, $name: String!) {
            editCategory(category: $category, name: $name) {
              id
              name
            }
          }
        GRAPHQL

        bicycle = categories(:bicycle)
        name_before = bicycle.name

        new_name = "foo"

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { category: bicycle.id, name: new_name })
        bicycle.reload

        ### Then
        assert_not_equal(bicycle.name, name_before)
      end
    end
  end
end

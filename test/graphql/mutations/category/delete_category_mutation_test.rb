require "test_helper"

module Mutations
  module Category
    class DeleteCategoryResolverTest < ActiveSupport::TestCase
      test "should soft delete a category" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($category: ID!) {
            deleteCategory(category: $category) {
              id
              name
            }
          }
        GRAPHQL

        bicycle = categories(:bicycle)

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { category: bicycle.id })
        bicycle.reload

        ### Then
        assert_not_nil(bicycle.deleted_at)
      end
    end
  end
end

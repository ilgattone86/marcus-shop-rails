require "test_helper"

module Mutations
  module Category
    class CreateCategoryResolverTest < ActiveSupport::TestCase
      test "should create a category" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($name: String!) {
            createCategory(name: $name) {
              id
              name
            }
          }
        GRAPHQL

        name = "foo"
        categories_before = ::Category.count

        ### When
        new_category = MarcusShopSchema.execute(mutation_string, variables: { name: name }).dig("data", "createCategory")
        categories_after = ::Category.count

        ### Then
        assert_not_nil(new_category)
        assert_equal(categories_after, categories_before + 1)
        assert_equal(new_category.dig("name"), name)
      end
    end
  end
end

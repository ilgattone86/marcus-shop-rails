require "test_helper"

module Resolvers
  class CategoriesResolverTest < ActiveSupport::TestCase
    test "should return both categories" do
      ### Given
      query_string = <<-GRAPHQL
        query {
          categories {
            id
          }
        }
      GRAPHQL
      bicycle = categories(:bicycle)

      ### When
      categories = MarcusShopSchema.execute(query_string).dig("data", "categories")
      categories_ids = categories.map { |c| c["id"] }

      ### Then
      assert_not_empty(categories_ids)
      assert_includes(categories_ids, bicycle.id.to_s)
    end
  end
end

require "test_helper"

module Resolvers
  class ProductsResolverTest < ActiveSupport::TestCase
    query_string = <<-GRAPHQL
      query {
        products {
          id
          name
        }
      }
    GRAPHQL

    test "should return the products" do
      ### Given
      bicycle = products(:first_bicycle)

      ### When
      products = MarcusShopSchema.execute(query_string).dig("data", "products")
      products_ids = products.map { |c| c["id"] }

      ### Then
      assert_not_empty(products_ids)
      assert_includes(products_ids, bicycle.id.to_s)
    end

    test "should return only products not deleted" do
      ### Given
      bicycle = products(:first_bicycle)
      bicycle.soft_delete

      ### When
      products = MarcusShopSchema.execute(query_string).dig("data", "products")
      products_ids = products.map { |c| c["id"] }

      ### Then
      assert_not_includes(products_ids, bicycle.id.to_s)
    end
  end
end

require "test_helper"

module Resolvers
  class ProductsResolverTest < ActiveSupport::TestCase
    query_string = <<-GRAPHQL
      query($product: ID!) {
        product(product: $product) {
          id
          name
        }
      }
    GRAPHQL

    test "should return the specific product" do
      ### Given
      bicycle = products(:first_bicycle)

      ### When
      product_id = MarcusShopSchema.execute(query_string, variables: {product: bicycle.id}).dig("data", "product", "id")

      ### Then
      assert_equal(bicycle.id.to_s, product_id)
    end
  end
end

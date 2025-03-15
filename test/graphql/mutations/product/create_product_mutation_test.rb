require "test_helper"

module Mutations
  module Product
    class CreateProductResolverTest < ActiveSupport::TestCase
      test "should create a product" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($name: String!, $description: String!, $category: ID!, $parts: [ ID! ]!) {
            createProduct(name: $name, description: $description, category: $category, parts: $parts) {
              id
              name
              description
              category {
                id
              }
              parts {
                id
              }
            }
          }
        GRAPHQL

        new_name = "New Product"
        new_description = "New Product Description"

        wheels = parts(:wheels)

        bicycle = categories(:bicycle)

        variables = { name: new_name,
                      description: new_description,
                      category: bicycle.id,
                      parts: [ wheels.id ] }

        products_before = ::Product.count

        ### When
        new_product = MarcusShopSchema.execute(mutation_string, variables: variables).dig("data", "createProduct")
        products_after = ::Product.count

        product_parts_ids = new_product.dig("parts").map { |part| part.dig("id") }

        ### Then
        assert_not_nil(new_product)
        assert_equal(products_after, products_before + 1)
        assert_equal(new_product.dig("name"), new_name)
        assert_equal(new_product.dig("description"), new_description)
        assert_equal(new_product.dig("category", "id"), bicycle.id.to_s)
        assert_equal(product_parts_ids.length, 1)
        assert_equal(product_parts_ids.first, wheels.id.to_s)
      end
    end
  end
end

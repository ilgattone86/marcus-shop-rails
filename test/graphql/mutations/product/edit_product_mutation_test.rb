require "test_helper"

module Mutations
  module Product
    class EditProductResolverTest < ActiveSupport::TestCase
      test "should edit a product" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($product: ID!, $name: String!, $parts: [ ID! ]!, $category: ID!, $description: String) {
            editProduct(product: $product, name: $name, parts: $parts, category: $category, description: $description) {
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

        product = products(:first_bicycle)
        chain = parts(:chain)
        bicycle = categories(:bicycle)

        new_name = "foo"
        new_description = "bar"
        new_parts = [ chain.id ]

        variables = { name: new_name,
                      parts: new_parts,
                      product: product.id,
                      category: bicycle.id,
                      description: new_description }

        ### When
        edited_product_result = MarcusShopSchema.execute(mutation_string, variables: variables)
        edited_product = edited_product_result.dig("data", "editProduct")
        product.reload

        edited_products_parts_ids = edited_product.dig("parts").map { |part| part.dig("id") }
        parts_ids = product.parts.map { |p| p.id.to_s }


        ### Then
        assert_equal(product.name, edited_product.dig("name"))
        assert_equal(product.description, edited_product.dig("description"))
        assert_equal(product.category_id.to_s, edited_product.dig("category", "id"))
        assert_equal(edited_products_parts_ids, parts_ids)
      end
    end
  end
end

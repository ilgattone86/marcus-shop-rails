require "test_helper"

module Mutations
  module Product
    class DeleteProductResolverTest < ActiveSupport::TestCase
      test "should soft delete a product" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($product: ID!) {
            deleteProduct(product: $product) {
              id
            }
          }
        GRAPHQL

        product = products(:first_bicycle)

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { product: product.id })
        product.reload

        ### Then
        assert_not_nil(product.deleted_at)
        assert(product.soft_deleted?)
      end
    end
  end
end

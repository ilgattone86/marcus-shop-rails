require "test_helper"

module Resolvers
  class PartsResolverTest < ActiveSupport::TestCase
    query_string = <<-GRAPHQL
      query($productId: ID) {
        parts(productId: $productId) {
          id
          name
        }
      }
    GRAPHQL

    test "should return the parts" do
      ### Given
      wheels = parts(:wheels)
      chain = parts(:chain)

      ### When
      parts = MarcusShopSchema.execute(query_string).dig("data", "parts")
      parts_ids = parts.map { |c| c["id"] }

      ### Then
      assert_not_empty(parts_ids)
      assert_includes(parts_ids, wheels.id.to_s)
      assert_includes(parts_ids, chain.id.to_s)
    end

    test "should return only parts not deleted" do
      ### Given
      wheels = parts(:wheels)
      wheels.soft_delete

      chain = parts(:chain)

      ### When
      parts = MarcusShopSchema.execute(query_string).dig("data", "parts")
      parts_ids = parts.map { |c| c["id"] }

      ### Then
      assert_not_includes(parts_ids, wheels.id.to_s)
      assert_includes(parts_ids, chain.id.to_s)
    end

    test "should return only parts associated with a product" do
      ### Given
      wheels = parts(:wheels)
      first_bicycle = products(:first_bicycle)
      first_bicycle.parts << wheels

      chain = parts(:chain)

      ### When
      parts = MarcusShopSchema.execute(query_string, variables: { productId: first_bicycle.id }).dig("data", "parts")
      parts_ids = parts.map { |c| c["id"] }

      ### Then
      assert_includes(parts_ids, wheels.id.to_s)
      assert_not_includes(parts_ids, chain.id.to_s)
    end
  end
end

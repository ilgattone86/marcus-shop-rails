require "test_helper"

module Resolvers
  class PartOptionResolverTest < ActiveSupport::TestCase
    query_string = <<-GRAPHQL
      query($product: ID) {
        partOptions(product: $product) {
          id
          name
        }
      }
    GRAPHQL

    test "should return the part options" do
      ### Given
      road_wheels = part_options(:road_wheels)
      eight_speed_chain = part_options(:eight_speed_chain)

      ### When
      part_options = MarcusShopSchema.execute(query_string).dig("data", "partOptions")
      part_options_ids = part_options.map { |c| c["id"] }

      ### Then
      assert_not_empty(part_options_ids)
      assert_includes(part_options_ids, road_wheels.id.to_s)
      assert_includes(part_options_ids, eight_speed_chain.id.to_s)
    end

    test "should return only part options not deleted" do
      ### Given
      road_wheels = part_options(:road_wheels)
      road_wheels.soft_delete

      eight_speed_chain = part_options(:eight_speed_chain)

      ### When
      part_options = MarcusShopSchema.execute(query_string).dig("data", "partOptions")
      part_options_ids = part_options.map { |c| c["id"] }

      ### Then
      assert_not_includes(part_options_ids, road_wheels.id.to_s)
      assert_includes(part_options_ids, eight_speed_chain.id.to_s)
    end

    test "should return only part options associated with a product" do
      ### Given
      road_wheels = part_options(:road_wheels)

      wheels = parts(:wheels)
      first_bicycle = products(:first_bicycle)
      first_bicycle.parts << wheels

      eight_speed_chain = part_options(:eight_speed_chain)

      ### When
      part_options = MarcusShopSchema.execute(query_string, variables: { product: first_bicycle.id }).dig("data", "partOptions")
      part_options_ids = part_options.map { |c| c["id"] }

      ### Then
      assert_includes(part_options_ids, road_wheels.id.to_s)
      assert_not_includes(part_options_ids, eight_speed_chain.id.to_s)
    end
  end
end

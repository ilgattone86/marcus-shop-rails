require "test_helper"

module Mutations
  module PartOption
    class EditPartOptionResolverTest < ActiveSupport::TestCase
      test "should edit a part option" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($partOption: ID!, $name: String!, $price: Float!, $stock: Boolean!, $part: ID!) {
            editPartOption(partOption: $partOption, name: $name, price: $price, stock: $stock, part: $part) {
              id
              name
              stock
              price
              part {
                id
              }
            }
          }
        GRAPHQL

        road_wheels = part_options(:road_wheels)
        new_name = "foo"
        new_price = rand(100..1000)
        new_stock = [ true, false ].sample
        new_part = parts(:chain)

        variables = { name: new_name,
                      price: new_price,
                      stock: new_stock,
                      part: new_part.id,
                      partOption: road_wheels.id }

        ### When
        edited_part_option_result = MarcusShopSchema.execute(mutation_string, variables: variables)
        edited_part_option = edited_part_option_result.dig("data", "editPartOption")

        road_wheels.reload

        ### Then
        assert_equal(road_wheels.name, edited_part_option["name"])
        assert_equal(road_wheels.price, edited_part_option["price"])
        assert_equal(road_wheels.stock, edited_part_option["stock"])
        assert_equal(road_wheels.part.id.to_s, edited_part_option.dig("part", "id").to_s)
      end
    end
  end
end

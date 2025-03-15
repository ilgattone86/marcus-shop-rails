require "test_helper"

module Mutations
  module PartOption
    class CreatePartOptionResolverTest < ActiveSupport::TestCase
      test "should create a part option" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($name: String!, $price: Float!, $stock: Boolean!, $part: ID!) {
            createPartOption(name: $name, price: $price, stock: $stock, part: $part) {
              id
              name
              price
              stock
              part {
                id
              }
            }
          }
        GRAPHQL

        name = "foo"
        price = 100
        stock = true
        part = parts(:wheels)

        variables = { name: name, price: price, stock: stock, part: part.id }

        part_options_before = ::PartOption.count

        ### When
        new_part = MarcusShopSchema.execute(mutation_string, variables: variables).dig("data", "createPartOption")
        part_options_after = ::PartOption.count

        ### Then
        assert_not_nil(new_part)
        assert_equal(part_options_after, part_options_before + 1)
        assert_equal(new_part.dig("name"), name)
        assert_equal(new_part.dig("price"), price)
        assert_equal(new_part.dig("stock"), stock)
        assert_equal(new_part.dig("part", "id"), part.id.to_s)
      end
    end
  end
end

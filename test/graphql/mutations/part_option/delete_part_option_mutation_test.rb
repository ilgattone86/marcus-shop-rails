require "test_helper"

module Mutations
  module PartOption
    class DeletePartOptionResolverTest < ActiveSupport::TestCase
      test "should soft delete a part option" do
        ### Given
        mutation_string = <<-GRAPHQL
          mutation($partOption: ID!) {
            deletePartOption(partOption: $partOption) {
              id
            }
          }
        GRAPHQL

        road_wheels = part_options(:road_wheels)

        ### When
        MarcusShopSchema.execute(mutation_string, variables: { partOption: road_wheels.id })
        road_wheels.reload

        ### Then
        assert_not_nil(road_wheels.deleted_at)
      end
    end
  end
end

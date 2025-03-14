require "test_helper"

module Services
  class ValidateNewProductServiceTest < ActiveSupport::TestCase
    test "should add errors if two options have a restriction" do
      ### Given
      road_wheels = part_options(:road_wheels)
      eight_speed_chain = part_options(:eight_speed_chain)
      service = ::ValidateNewProductService.new([ road_wheels.id.to_s, eight_speed_chain.id.to_s ])

      ### When
      service.validate

      ### Then
      assert_not_empty(service.errors.full_messages)
    end

    test "should not add errors if there is no restriction for the base option" do
      ### Given
      ::Restriction.destroy_all

      road_wheels = part_options(:road_wheels)
      eight_speed_chain = part_options(:eight_speed_chain)
      service = ::ValidateNewProductService.new([ road_wheels.id.to_s, eight_speed_chain.id.to_s ])

      ### Then
      assert(service.validate)
    end
  end
end

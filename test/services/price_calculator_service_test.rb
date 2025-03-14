require "test_helper"

module Services
  class PriceCalculatorServiceTest < ActiveSupport::TestCase
    test "should return the correct price for the options" do
      ### Given
      ::PriceRule.destroy_all

      road_wheels = part_options(:road_wheels)
      eight_speed_chain = part_options(:eight_speed_chain)

      total_price = road_wheels.price + eight_speed_chain.price
      service = ::PriceCalculatorService.new([ road_wheels.id, eight_speed_chain.id ])

      ### When
      computed_price = service.compute_price

      ### Then
      assert_equal(total_price, computed_price)
    end

    test "should take into account also the price rules" do
      ### Given
      ::PriceRule.destroy_all

      road_wheels = part_options(:road_wheels)
      eight_speed_chain = part_options(:eight_speed_chain)
      price_rule = ::PriceRule.create!(price_adjustment: 10.0,
                                       base_option: road_wheels,
                                       dependent_option: eight_speed_chain)

      total_price = road_wheels.price + eight_speed_chain.price + price_rule.price_adjustment
      service = ::PriceCalculatorService.new([ road_wheels.id, eight_speed_chain.id ])

      ### When
      computed_price = service.compute_price

      ### Then
      assert_equal(total_price, computed_price)
    end
  end
end

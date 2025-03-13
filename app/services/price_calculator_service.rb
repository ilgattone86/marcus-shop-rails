# frozen_string_literal: true

class PriceCalculatorService

  def initialize(options)
    @price = 0.0
    @options = ::PartOption.find(options)
  end

  def compute_price
    add_default_part_price
    add_composed_price

    @price
  end

  private

  def add_default_part_price
    @price += @options.sum(&:price)
  end

  def add_composed_price
    price_rules = ::PriceRule.for_base_option(@options)

    price_rules.each do |price_rule|
      next if @options.exclude?(price_rule.dependent_option_id)

      @price += price_rule.price_adjustment
    end
  end
end

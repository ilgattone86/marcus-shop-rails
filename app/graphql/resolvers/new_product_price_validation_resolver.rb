# frozen_string_literal: true

module Resolvers
  class NewProductPriceValidationResolver < ::Resolvers::BaseResolver
    argument :options, [ ID ], required: true

    type Types::NewProductPriceValidationType, null: false

    def resolve(options:)
      validation_service = ::ValidateNewProductService.new(options)
      price_calculator_service = ::PriceCalculatorService.new(options)

      price = validation_service.valid? ? price_calculator_service.compute_price : 0.0

      {
        errors: validation_service.errors.full_messages,
        price: price
      }
    end
  end
end

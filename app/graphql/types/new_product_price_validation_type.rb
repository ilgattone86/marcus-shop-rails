module Types
  class NewProductPriceValidationType < GraphQL::Schema::Object
    field :price, Float, null: false
    field :errors, [ String ], null: false
  end
end

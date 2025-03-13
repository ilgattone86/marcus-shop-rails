module Types
  class PriceRuleType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :price_adjustment, Float, null: false
    field :base_option, ::Types::PartOptionType, null: false
    field :dependent_option, ::Types::PartOptionType, null: false
  end
end

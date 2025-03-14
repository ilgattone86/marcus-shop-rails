module Types
  class PartOptionType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :price, Float, null: false
    field :stock, Boolean, null: false
    field :part, Types::PartType, null: false
  end
end

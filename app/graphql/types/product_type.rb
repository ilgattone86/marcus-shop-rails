module Types
  class ProductType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :category, Types::CategoryType, null: false
    field :parts, [ Types::PartType ], null: false
  end
end

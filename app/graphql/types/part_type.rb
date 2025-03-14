module Types
  class PartType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :part_options, [ Types::PartOptionType ], null: false
  end
end

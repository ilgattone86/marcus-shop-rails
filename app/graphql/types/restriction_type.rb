module Types
  class RestrictionType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :blocked_option, ::Types::PartOptionType, null: false
    field :dependent_option, ::Types::PartOptionType, null: false
  end
end

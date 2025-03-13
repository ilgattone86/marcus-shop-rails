module Types
  class UserType < GraphQL::Schema::Object
    field :name, String, null: false
  end
end

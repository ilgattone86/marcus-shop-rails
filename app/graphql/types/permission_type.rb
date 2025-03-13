module Types
  class PermissionType < GraphQL::Schema::Object
    field :name, String, null: false
  end
end

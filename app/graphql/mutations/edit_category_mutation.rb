# frozen_string_literal: true

module Mutations
  class EditCategoryMutation < ::Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true

    type Types::CategoryType

    def resolve(id:, name:)
      category = ::Category.find(id)
      category.update!(name: name)
      category
    end
  end
end

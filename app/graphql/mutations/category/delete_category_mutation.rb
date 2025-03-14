# frozen_string_literal: true

module Mutations
  class CreateCategoryMutation < ::Mutations::BaseMutation
    argument :name, String, required: true

    type Types::CategoryType

    def resolve(name:)
      Category.create!(name: name)
    end
  end
end

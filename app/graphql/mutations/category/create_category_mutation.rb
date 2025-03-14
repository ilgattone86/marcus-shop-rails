# frozen_string_literal: true

module Mutations
  module Category
    class CreateCategoryMutation < ::Mutations::BaseMutation
      argument :name, String, required: true

      type Types::CategoryType

      def resolve(name:)
        ::Category.create!(name: name)
      end
    end
  end
end

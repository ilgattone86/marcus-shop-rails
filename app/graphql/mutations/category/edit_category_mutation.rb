# frozen_string_literal: true

module Mutations
  module Category
    class EditCategoryMutation < ::Mutations::BaseMutation
      argument :category, ID, required: true, prepare: ->(category, _) { ::Category.find(category) }
      argument :name, String, required: true

      type ::Types::CategoryType

      def resolve(category:, name:)
        category.update!(name: name)

        category
      end
    end
  end
end

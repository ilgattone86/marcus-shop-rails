# frozen_string_literal: true

module Mutations
  module Category
    class DeleteCategoryMutation < ::Mutations::BaseMutation
      argument :category, ID, required: true, prepare: ->(category, _) { ::Category.find(category) }

      type Types::CategoryType

      def resolve(category:)
        category.soft_delete

        category
      end
    end
  end
end

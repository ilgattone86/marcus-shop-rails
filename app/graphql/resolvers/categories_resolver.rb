# frozen_string_literal: true

module Resolvers
  class CategoriesResolver < ::Resolvers::BaseResolver
    type [ Types::CategoryType ], null: false

    def resolve
      ::Category.all
    end
  end
end

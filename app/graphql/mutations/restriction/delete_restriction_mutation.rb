# frozen_string_literal: true

module Mutations
  module Restriction
    class DeleteRestrictionMutation < ::Mutations::BaseMutation
      argument :restriction, ID, required: true, prepare: ->(restriction, _) { ::Restriction.find(restriction) }

      type Types::RestrictionType

      def resolve(restriction:)
        restriction.destroy

        restriction
      end
    end
  end
end

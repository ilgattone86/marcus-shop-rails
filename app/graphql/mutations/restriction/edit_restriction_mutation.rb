# frozen_string_literal: true

module Mutations
  module Restriction
    class EditRestrictionMutation < ::Mutations::BaseMutation
      argument :dependent_option, ID, required: true, prepare: ->(dependent_option, _) { ::PartOption.find(dependent_option) }
      argument :restriction, ID, required: true, prepare: ->(restriction, _) { ::Restriction.find(restriction) }
      argument :blocked_option, ID, required: true, prepare: ->(blocked_option, _) { ::PartOption.find(blocked_option) }

      type Types::RestrictionType

      def resolve(restriction:, dependent_option:, blocked_option:)
        restriction.update!(dependent_option: dependent_option, blocked_option: blocked_option)

        restriction
      end
    end
  end
end

# frozen_string_literal: true

module Mutations
  module Restriction
    class CreateRestrictionMutation < ::Mutations::BaseMutation
      argument :blocked_option, ID, required: true, prepare: ->(blocked_option, _) { ::PartOption.find(blocked_option) }
      argument :dependent_option, ID, required: true, prepare: ->(dependent_option, _) { ::PartOption.find(dependent_option) }

      type Types::RestrictionType

      def resolve(dependent_option:, blocked_option:)
        ::Restriction.create!(dependent_option: dependent_option, blocked_option: blocked_option)
      end
    end
  end
end

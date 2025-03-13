# frozen_string_literal: true

module Mutations
  module PartOption
    class DeletePartOptionMutation < ::Mutations::BaseMutation
      argument :part_option, ID, required: true, prepare: ->(part_option, _) { ::PartOption.find(part_option) }

      type Types::PartOptionType

      def resolve(part_option:)
        part_option.soft_delete

        part_option
      end
    end
  end
end

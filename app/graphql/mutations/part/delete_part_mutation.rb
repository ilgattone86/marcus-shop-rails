# frozen_string_literal: true

module Mutations
  module Part
    class DeletePartMutation < ::Mutations::BaseMutation
      argument :part, ID, required: true, prepare: ->(part, _ctx) { ::Part.find(part) }

      type Types::PartType

      def resolve(part:)
        part.soft_delete
        part
      end
    end
  end
end

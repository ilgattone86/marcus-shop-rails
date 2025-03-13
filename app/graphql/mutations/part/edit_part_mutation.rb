# frozen_string_literal: true

module Mutations
  module Part
    class EditPartMutation < ::Mutations::BaseMutation
      argument :part, ID, required: true, prepare: ->(id, _ctx) { ::Part.find(id) }
      argument :name, String, required: true

      type Types::PartType

      def resolve(part:, name:)
        part.update!(name: name)
        part
      end
    end
  end
end

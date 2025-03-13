# frozen_string_literal: true

module Mutations
  module Part
    class CreatePartMutation < ::Mutations::BaseMutation
      argument :name, String, required: true

      type Types::PartType

      def resolve(name:)
        ::Part.create!(name: name)
      end
    end
  end
end

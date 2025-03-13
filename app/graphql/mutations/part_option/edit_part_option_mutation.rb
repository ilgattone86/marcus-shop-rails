# frozen_string_literal: true

module Mutations
  module PartOption
    class EditPartOptionMutation < ::Mutations::BaseMutation
      argument :part_option, ID, required: true, prepare: ->(part_option, _) { ::PartOption.find(part_option) }
      argument :name, String, required: true
      argument :price, Float, required: true
      argument :part, ID, required: true, prepare: ->(part, _) { ::PartOption.find(part) }

      type Types::PartOptionType

      def resolve(part_option:, name:, price:, part:)
        part_option.update!(name: name, price: price, part: part)

        part_option
      end
    end
  end
end

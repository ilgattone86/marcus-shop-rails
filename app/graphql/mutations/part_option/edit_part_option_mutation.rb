# frozen_string_literal: true

module Mutations
  module PartOption
    class EditPartOptionMutation < ::Mutations::BaseMutation
      argument :part_option, ID, required: true, prepare: ->(part_option, _) { ::PartOption.find(part_option) }
      argument :name, String, required: true
      argument :price, Float, required: true
      argument :stock, Boolean, required: true
      argument :part, ID, required: true, prepare: ->(part, _) { ::Part.find(part) }

      type Types::PartOptionType

      def resolve(part_option:, name:, price:, part:, stock:)
        part_option.update!(name: name, price: price, part: part, stock: stock)

        part_option
      end
    end
  end
end

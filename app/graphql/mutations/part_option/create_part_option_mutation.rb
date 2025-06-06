# frozen_string_literal: true

module Mutations
  module PartOption
    class CreatePartOptionMutation < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :price, Float, required: true
      argument :stock, Boolean, required: true
      argument :part, ID, required: true, prepare: ->(part, _) { ::Part.find(part) }

      type Types::PartOptionType

      def resolve(name:, price:, part:, stock:)
        ::PartOption.create!(name: name, price: price, part: part, stock: stock)
      end
    end
  end
end

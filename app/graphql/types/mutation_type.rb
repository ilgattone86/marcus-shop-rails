# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Category
    field :edit_category, mutation: ::Mutations::EditCategoryMutation
    field :create_category, mutation: ::Mutations::CreateCategoryMutation

    # Product
    field :edit_product, mutation: ::Mutations::Product::EditProductMutation
    field :delete_product, mutation: ::Mutations::Product::DeleteProductMutation
    field :create_product, mutation: ::Mutations::Product::CreateProductMutation

    # Part
    field :edit_part, mutation: ::Mutations::Part::EditPartMutation
    field :create_part, mutation: ::Mutations::Part::CreatePartMutation
    field :delete_part, mutation: ::Mutations::Part::DeletePartMutation

    # PartOption
    field :edit_part_option, mutation: ::Mutations::PartOption::EditPartOptionMutation
    field :create_part_option, mutation: ::Mutations::PartOption::CreatePartOptionMutation
    field :delete_part_option, mutation: ::Mutations::PartOption::DeletePartOptionMutation

    # Restriction
    field :edit_restriction, mutation: ::Mutations::Restriction::EditRestrictionMutation
    field :create_restriction, mutation: ::Mutations::Restriction::CreateRestrictionMutation
    field :delete_restriction, mutation: ::Mutations::Restriction::DeleteRestrictionMutation

    # Price rule
    field :edit_price_rule, mutation: ::Mutations::PriceRule::EditPriceRuleMutation
    field :create_price_rule, mutation: ::Mutations::PriceRule::CreatePriceRuleMutation
    field :delete_price_rule, mutation: ::Mutations::PriceRule::DeletePriceRuleMutation
  end
end

# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :products,
          null: false,
          resolver: ::Resolvers::ProductsResolver,
          description: "Returns list of products"

    field :product,
          null: false,
          resolver: ::Resolvers::ProductResolver,
          description: "Returns a single product"

    field :parts,
          null: false,
          resolver: ::Resolvers::PartsResolver,
          description: "Returns a list parts"

    field :part_options,
          null: false,
          resolver: ::Resolvers::PartOptionsResolver,
          description: "Returns a list part options"

    field :new_product_price_validation,
          null: false,
          resolver: ::Resolvers::NewProductPriceValidationResolver,
          description: "Validate a new product and calculate its price"

    field :user,
          null: false,
          resolver: ::Resolvers::UserResolver,
          description: "Return a user"

    field :user_permissions,
          null: false,
          resolver: ::Resolvers::UserPermissionsResolver,
          description: "Return a user"

    field :categories,
          null: false,
          resolver: ::Resolvers::CategoriesResolver,
          description: "Return a list of categories"

    field :restrictions,
          null: false,
          resolver: ::Resolvers::RestrictionsResolver,
          description: "Return a list of restrictions"

    field :price_rules,
          null: false,
          resolver: ::Resolvers::PriceRulesResolver,
          description: "Return a list of price rules"
  end
end

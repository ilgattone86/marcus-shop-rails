# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :products,
          null: false,
          resolver: ::Resolvers::ProductsResolver,
          description: "Returns a paginated list of products"

    field :all_products,
          null: false,
          resolver: ::Resolvers::AllProductsResolver,
          description: "Returns all products"

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

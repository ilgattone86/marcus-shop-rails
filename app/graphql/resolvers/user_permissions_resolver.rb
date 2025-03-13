# frozen_string_literal: true

module Resolvers
  class UserPermissionsResolver < ::Resolvers::BaseResolver
    argument :email, String, required: true
    argument :permissions, [ String ], required: false

    type [ Types::PermissionType ], null: false

    def resolve(email:, permissions:)
      ::Permission.for_user_email(email).filter_for_permission_name(permissions)
    end
  end
end

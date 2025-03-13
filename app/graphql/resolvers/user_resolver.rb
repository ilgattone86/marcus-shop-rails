# frozen_string_literal: true

module Resolvers
  class UserResolver < ::Resolvers::BaseResolver
    argument :email, String, required: true

    type Types::UserType, null: false

    def resolve(email:)
      ::User.find_by!(email_address: email)
    end
  end
end

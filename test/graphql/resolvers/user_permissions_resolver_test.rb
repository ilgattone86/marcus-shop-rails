require "test_helper"

module Resolvers
  class UserPermissionsResolverTest < ActiveSupport::TestCase
    query_string = <<-GRAPHQL
      query($email: String!, $permissions: [String!]) {
        userPermissions(email: $email, permissions: $permissions) {
          name
        }
      }
    GRAPHQL

    test "should return all the permissions for the user with the email passed as param" do
      ### Given
      user = users(:first_user)
      user_email = user.email_address

      ### When
      permissions_result = MarcusShopSchema.execute(query_string, variables: { email: user_email })
      permissions = permissions_result.dig("data", "userPermissions")

      ### Then
      assert_not_empty(permissions)
    end

    test "should return only settings permission" do
      ### Given
      user = users(:first_user)
      user_email = user.email_address

      ### When
      permissions_result = MarcusShopSchema.execute(query_string, variables: { email: user_email, permissions: ["settings"] })
      permissions = permissions_result.dig("data", "userPermissions").map { |permission| permission["name"] }

      ### Then
      assert_not_empty(permissions)
      assert_equal([ "settings" ], permissions)
    end
  end
end

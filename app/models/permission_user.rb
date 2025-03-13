# == Schema Information
#
# Table name: permission_users
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  permission_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_permission_users_on_permission_id  (permission_id)
#  index_permission_users_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (permission_id => permissions.id)
#  fk_rails_...  (user_id => users.id)
#
class PermissionUser < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :permission
end

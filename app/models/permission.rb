# == Schema Information
#
# Table name: permissions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Permission < ApplicationRecord
  # Associations
  has_many :permission_users, dependent: :destroy
  has_many :users_with_permission, through: :permission_users, source: :user, dependent: :destroy

  # Scope
  scope :for_permission_name, ->(name) { where(name: name) }
  scope :for_user_email, ->(email) { joins(:users_with_permission).merge(::User.for_email(email)) }

  # Filters
  scope :filter_for_permission_name, lambda { |permissions|
    return if permissions.blank?

    for_permission_name(permissions)
  }
end

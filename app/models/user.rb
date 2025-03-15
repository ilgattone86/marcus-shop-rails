# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  # Associations
  has_many :sessions, dependent: :destroy
  has_many :permission_users, dependent: :destroy
  has_many :permissions, through: :permission_users

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Scopes
  scope :for_email, ->(email) { where(email_address: email) }
end

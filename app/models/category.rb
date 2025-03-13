# == Schema Information
#
# Table name: categories
#
#  id                                           :bigint           not null, primary key
#  deleted_at(Soft deleted timestamp)           :datetime
#  description(The description of the category) :string
#  name(The name of the category)               :string           not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#
class Category < ApplicationRecord
  include ::SoftDelete

  # Associations
  has_many :products, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

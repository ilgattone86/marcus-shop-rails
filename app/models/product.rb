# == Schema Information
#
# Table name: products
#
#  id                                          :bigint           not null, primary key
#  deleted_at(Soft deleted timestamp)          :datetime
#  description(The description of the product) :string
#  name(The name of the product)               :string           not null
#  created_at                                  :datetime         not null
#  updated_at                                  :datetime         not null
#  category_id(The category of the product)    :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Product < ApplicationRecord
  include ::SoftDelete

  # Associations
  belongs_to :category

  has_many :product_parts, dependent: :destroy
  has_many :parts, through: :product_parts, dependent: :destroy
end

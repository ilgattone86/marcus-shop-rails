# == Schema Information
#
# Table name: parts
#
#  id                                 :bigint           not null, primary key
#  deleted_at(Soft deleted timestamp) :datetime
#  name(The name of the part)         :string           not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
class Part < ApplicationRecord
  include ::SoftDelete

  # Associations
  has_many :part_options, dependent: :destroy
  has_many :product_parts, dependent: :destroy
  has_many :products_using_this_part, through: :product_parts, source: :product, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Scopes
  scope :for_product, ->(product) { joins(:products_using_this_part).merge(::Product.where(id: product)) }

  # Filters
  scope :filter_for_product, lambda { |product|
    return if product.blank?

    for_product(product)
  }
end

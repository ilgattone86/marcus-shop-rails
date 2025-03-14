# == Schema Information
#
# Table name: part_options
#
#  id                                           :bigint           not null, primary key
#  deleted_at(Soft deleted timestamp)           :datetime
#  name(The name of the option)                 :string           not null
#  price(The price of the option)               :decimal(8, 2)    default(0.0), not null
#  stock                                        :boolean          default(TRUE), not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#  part_id(The part that the option belongs to) :bigint           not null
#
# Indexes
#
#  index_part_options_on_part_id  (part_id)
#
# Foreign Keys
#
#  fk_rails_...  (part_id => parts.id)
#
class PartOption < ApplicationRecord
  include ::SoftDelete

  # Associations
  belongs_to :part

  has_many :price_rules_as_base, foreign_key: :base_option_id, class_name: "PriceRule", dependent: :destroy
  has_many :price_rules_as_dependent, foreign_key: :dependent_option_id, class_name: "PriceRule", dependent: :destroy

  has_many :restrictions_as_dependent, foreign_key: :dependent_option_id, class_name: "Restriction", dependent: :destroy
  has_many :restrictions_as_blocked, foreign_key: :blocked_option_id, class_name: "Restriction", dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  # Scope
  scope :for_part, ->(part) { where(part: part) }
  scope :for_stock, ->(stock) { where(stock: stock) }
  scope :for_product, ->(product) { joins(:part).merge(::Part.for_product(product)) }

  # Filters
  scope :filter_for_product, lambda { |product|
    return if product.blank?

    for_product(product)
  }

  scope :filter_for_stock, lambda { |stock|
    return if stock.nil?

    for_stock(stock)
  }
end

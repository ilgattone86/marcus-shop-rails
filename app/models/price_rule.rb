# == Schema Information
#
# Table name: price_rules
#
#  id                                                             :bigint           not null, primary key
#  price_adjustment(The price adjustment for the pair of options) :decimal(8, 2)    default(0.0), not null
#  created_at                                                     :datetime         not null
#  updated_at                                                     :datetime         not null
#  base_option_id(The option that has the base price)             :bigint           not null
#  dependent_option_id(The option that has specific price rules)  :bigint           not null
#
# Indexes
#
#  index_price_rules_on_base_option_id       (base_option_id)
#  index_price_rules_on_dependent_option_id  (dependent_option_id)
#
# Foreign Keys
#
#  fk_rails_...  (base_option_id => part_options.id)
#  fk_rails_...  (dependent_option_id => part_options.id)
#
class PriceRule < ApplicationRecord
  # Associations
  belongs_to :base_option, class_name: "PartOption", inverse_of: :price_rules_as_base
  belongs_to :dependent_option, class_name: "PartOption", inverse_of: :price_rules_as_dependent

  # Validations
  validates :price_adjustment, presence: true, numericality: { greater_than: 0 }

  # Scopes
  scope :for_base_option, ->(base) { where(base_option: base) }
  scope :for_dependent_option, ->(dependent) { where(dependent_option: dependent) }
  scope :for_options, ->(base, dependent) { where(base_option: base, dependent_option: dependent) }
end

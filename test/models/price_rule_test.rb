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
require "test_helper"

class PriceRuleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

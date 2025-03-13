# == Schema Information
#
# Table name: stocks
#
#  id                                                        :bigint           not null, primary key
#  number_of_units(The number of units in stock)             :integer          default(0), not null
#  created_at                                                :datetime         not null
#  updated_at                                                :datetime         not null
#  part_option_id(The part option that the stock belongs to) :bigint           not null
#
# Indexes
#
#  index_stocks_on_part_option_id  (part_option_id)
#
# Foreign Keys
#
#  fk_rails_...  (part_option_id => part_options.id)
#
require "test_helper"

class StockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

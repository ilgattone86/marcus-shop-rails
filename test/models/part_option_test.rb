# == Schema Information
#
# Table name: part_options
#
#  id                                           :bigint           not null, primary key
#  deleted_at(Soft deleted timestamp)           :datetime
#  name(The name of the option)                 :string           not null
#  price(The price of the option)               :decimal(8, 2)    default(0.0), not null
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
require "test_helper"

class PartOptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

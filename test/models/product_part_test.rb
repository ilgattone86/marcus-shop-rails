# == Schema Information
#
# Table name: product_parts
#
#  id                                                :bigint           not null, primary key
#  created_at                                        :datetime         not null
#  updated_at                                        :datetime         not null
#  part_id(The part that the product has)            :bigint           not null
#  product_id(The product which the part belongs to) :bigint           not null
#
# Indexes
#
#  index_product_parts_on_part_id     (part_id)
#  index_product_parts_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (part_id => parts.id)
#  fk_rails_...  (product_id => products.id)
#
require "test_helper"

class ProductPartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

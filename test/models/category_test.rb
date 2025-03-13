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
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

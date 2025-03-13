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
require "test_helper"

class PartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: restrictions
#
#  id                                                                     :bigint           not null, primary key
#  created_at                                                             :datetime         not null
#  updated_at                                                             :datetime         not null
#  blocked_option_id(The option that is blocked for the dependent option) :bigint           not null
#  dependent_option_id(The option that has some restrictions)             :bigint           not null
#
# Indexes
#
#  index_restrictions_on_blocked_option_id    (blocked_option_id)
#  index_restrictions_on_dependent_option_id  (dependent_option_id)
#
# Foreign Keys
#
#  fk_rails_...  (blocked_option_id => part_options.id)
#  fk_rails_...  (dependent_option_id => part_options.id)
#
require "test_helper"

class RestrictionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

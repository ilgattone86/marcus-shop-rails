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
class Restriction < ApplicationRecord
  # Associations
  belongs_to :dependent_option, class_name: "PartOption", inverse_of: :restrictions_as_dependent
  belongs_to :blocked_option, class_name: "PartOption", inverse_of: :restrictions_as_blocked

  # Validations
  validate :different_part
  validate :unique_restriction_pair


  # Scopes
  scope :for_dependent_option, ->(dependent_option) { where(dependent_option: dependent_option) }
  scope :for_dependent_blocked, lambda { |dependent_option, blocked_option|
    where(dependent_option: dependent_option, blocked_option: blocked_option)
  }

  # Filters
  scope :filter_for_dependent_option, lambda { |dependent_option|
    return if dependent_option.blank?

    for_dependent_option(dependent_option)
  }

  private

  # Ensures that the restriction pair is unique, preventing duplicate or reversed entries.
  #
  # @return [void]
  #
  # @raise [ActiveRecord::RecordInvalid] if a restriction already exists in reverse order.
  def unique_restriction_pair
    exists_dependent_blocked = ::Restriction.for_dependent_blocked(dependent_option, blocked_option)
    exists_blocked_dependent = ::Restriction.for_dependent_blocked(blocked_option, dependent_option)

    exists_pair = exists_dependent_blocked.or(exists_blocked_dependent).exists?
    errors.add(:base, "This restriction already exists in reverse order") if exists_pair
  end

  # Ensures that the dependent and blocked options belong to different parts.
  #
  # @return [void]
  #
  # @raise [ActiveRecord::RecordInvalid] if both options belong to the same part.
  def different_part
    return if dependent_option.part != blocked_option.part

    errors.add(:base, "The dependent and blocked options must be from different parts")
  end
end

# frozen_string_literal: true

class ValidateNewProductService
  include ActiveModel::Validations

  # @param options [Array<Integer>] An array of selected option IDs.
  def initialize(options)
    @options = options
  end

  # Validations
  validate :validate_restrictions

  # Checks if any selected options are restricted from being chosen together.
  #
  # @return [void]
  #
  # @raise [ActiveModel::ValidationError] if any restrictions are violated.
  def validate_restrictions
    restriction_for_options = ::Restriction.for_dependent_option(@options)

    restriction_for_options.each do |restriction|
      if @options.include?(restriction.blocked_option_id.to_s)
        error_text = <<~TEXT
          #{restriction.dependent_option.name} cannot be selected with #{restriction.blocked_option.name}
        TEXT

        errors.add(:base, error_text)
      end
    end
  end
end

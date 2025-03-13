# frozen_string_literal: true

class ValidateNewProductService
  include ActiveModel::Validations

  def initialize(options)
    @options = options
  end

  # Validations
  validate :validate_restrictions

  def validate_restrictions
    restriction_for_options = ::Restriction.for_dependent_option(@options)

    restriction_for_options.each do |restriction|
      if @options.include?(restriction.blocked_option_id.to_s)
        errors.add(:base, <<~TEXT
          #{restriction.dependent_option.name} cannot be selected with #{restriction.blocked_option.name}
        TEXT
        )
      end
    end
  end

end

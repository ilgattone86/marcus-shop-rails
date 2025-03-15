module SoftDelete
  extend ActiveSupport::Concern

  included do
    scope :not_deleted, -> { where(deleted_at: nil) }
    scope :deleted,     -> { where.not(deleted_at: nil) }
    scope :for_deleted, ->(deleted_boolean) { deleted_boolean ? deleted : not_deleted }
  end

  def restore
    self.deleted_at = nil
    save(validate: false)
  end

  def soft_deleted?
    deleted_at.present?
  end

  def not_soft_deleted?
    deleted_at.blank?
  end

  def soft_delete
    if soft_deleted?
      true
    else
      now = Time.current
      self.deleted_at = now
      self.updated_at = now
      save(validate: false)
    end
  end
end

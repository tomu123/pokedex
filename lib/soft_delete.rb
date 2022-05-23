# frozen_string_literal: true

# Module Soft Delete
module SoftDelete
  def self.included(klass)
    klass.class_eval do
      default_scope { where(deleted_at: nil) }
      scope :filter_deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
      scope :filter_all, -> { unscope(where: :deleted_at) }

      def self.filter(value)
        return public_send("all") if value.blank?

        message = "Invalid filter: #{value}"
        raise ArgumentError, message unless %w[all deleted].include?(value)

        public_send("filter_#{value}")
      end
    end
  end

  def soft_destroy
    update(deleted_at: Time.current)
  end

  def recover
    update(deleted_at: nil)
  end
end

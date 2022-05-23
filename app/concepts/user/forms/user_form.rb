# frozen_string_literal: true

class User
  module Forms
    class UserForm < Reform::Form
      property :email
      property :given_name
      property :family_name
      property :user_role

      validates :email, :given_name, :family_name, presence: true
      validate :user_role_valid?
      validate :unique_email?, unless: -> { email.blank? }

      private

      def user_role_valid?
        errors.add(:user_role, "Invalid User Role") if user_role.present? && !%w[trainer doctor].include?(user_role)
      end

      def unique_email?
        user = User.unscoped.find_by(email: email)
        errors.add(:email, 'Email has already been taken') if user.present?
      end
    end
  end
end

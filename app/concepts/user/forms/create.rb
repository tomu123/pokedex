# frozen_string_literal: true

class User
  module Forms
    class Create
      include ActiveModel::Model

      attr_accessor :email, :given_name, :family_name, :user_role

      validates :email, :given_name, :family_name, presence: true
      validate :user_role_valid?, :unique_email?

      private

      def user_role_valid?
        errors.add(:user_role, "Invalid User Role") if user_role.present? && !%w[trainer doctor].include?(user_role)
      end

      def unique_email?
        user = User.find_by(email: email)
        errors.add(:email, 'Email has already been taken') if user.present?
      end
    end
  end
end

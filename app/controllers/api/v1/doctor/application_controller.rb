# frozen_string_literal: true

module Api
  module V1
    module Doctor
      class ApplicationController < ApplicationController
        # equivalent of authenticate_user! on devise, but this one will check the oauth token
        before_action :doorkeeper_authorize!, :current_user, :authorize_role

        private

        def authorize_role
          raise CustomError.new(status: :unauthorized) unless @current_user.doctor_role?
        end
      end
    end
  end
end

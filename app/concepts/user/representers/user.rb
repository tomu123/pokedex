# frozen_string_literal: true

class User
  module Representers
    class User < Application::Representers::ApplicationRepresenter
      property :id
      property :email
      property :given_name
      property :family_name
      property :user_role
    end
  end
end

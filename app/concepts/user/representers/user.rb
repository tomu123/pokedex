# frozen_string_literal: true

class User
  module Representer
    class User < Application::Representer::ApplicationRepresenter
      property :id
      property :email
      property :given_name
      property :family_name
      property :user_role
    end
  end
end

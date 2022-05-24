# frozen_string_literal: true

class Type
  module Representers
    class Type < Application::Representers::ApplicationRepresenter
      property :id
      property :name
    end
  end
end

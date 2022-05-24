# frozen_string_literal: true

class Region
  module Representers
    class Region < Application::Representers::ApplicationRepresenter
      property :id
      property :name
    end
  end
end

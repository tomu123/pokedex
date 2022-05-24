# frozen_string_literal: true

class Type
  module Operations
    class Search < Application::Operations::Search
      pass :fetch_types
      pass :filter_and_sort_relation
      pass Subprocess(Application::Operations::Pagination)
      pass :set_representer
      pass :render_json

      def fetch_types(ctx, **)
        ctx[:relation] = Type.all
      end

      def set_representer(ctx, **)
        ctx[:representer] = Type::Representers::Type
      end
    end
  end
end

# frozen_string_literal: true

class Region
  module Operations
    class Search < Application::Operations::Search
      pass :fetch_regions
      pass :filter_and_sort_relation
      pass Subprocess(Application::Operations::Pagination)
      pass :set_representer
      pass :render_json

      def fetch_regions(ctx, **)
        ctx[:relation] = Region.all
      end

      def set_representer(ctx, **)
        ctx[:representer] = Region::Representers::Region
      end
    end
  end
end

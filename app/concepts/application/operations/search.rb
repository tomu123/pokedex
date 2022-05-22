# frozen_string_literal: true

module Application
  module Operations
    class Search < Trailblazer::Operation
      include Pagy::Backend

      def filter_and_sort_relation(ctx, query:, relation:, **)
        ctx[:relation] = relation.ransack(query).result
      end

      def render_json(ctx, representer:, collection:, pagy:, **)
        response = representer.jsonapi_for_collection(collection)
        response[:meta] = {
          'current_page' => pagy.page,
          'page_items' => pagy.items,
          'total_pages' => pagy.pages,
          'total_count' => pagy.count
        }
        ctx[:json] = response.to_json
      end
    end
  end
end

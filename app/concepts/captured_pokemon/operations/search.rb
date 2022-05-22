# frozen_string_literal: true

class Pokemon
  module Operations
    class Search < Application::Operations::Search
      pass :fetch_pokemons
      pass :filter_and_sort_relation
      pass Subprocess(Application::Operations::Pagination)
      pass :set_representer
      pass :render_json

      def fetch_pokemons(ctx, **)
        ctx[:relation] = Pokemon.all
      end

      def set_representer(ctx, **)
        ctx[:representer] = Pokemon::Representers::Pokemon
      end
    end
  end
end

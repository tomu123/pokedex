# frozen_string_literal: true

class CapturedPokemon
  module Operations
    class Search < Application::Operations::Search
      pass :fetch_captured_pokemons
      pass :filter_and_sort_relation
      pass Subprocess(Application::Operations::Pagination)
      pass :set_representer
      pass :render_json

      def fetch_captured_pokemons(ctx, filter: 'captured', **)
        case filter
        when 'captured'
          ctx[:relation] = CapturedPokemon.all
        when 'released'
          ctx[:relation] = CapturedPokemon.filter('deleted')
        else
          ctx[:relation] = CapturedPokemon.filter(filter)
        end
      end

      def set_representer(ctx, **)
        ctx[:representer] = CapturedPokemon::Representers::CapturedPokemon
      end
    end
  end
end

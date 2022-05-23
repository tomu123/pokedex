# frozen_string_literal: true

class CapturedPokemon
  module Operations
    class Search < Application::Operations::Search
      pass :filter_captured_pokemons
      pass :fetch_captured_pokemons
      pass :filter_and_sort_relation
      pass Subprocess(Application::Operations::Pagination)
      pass :set_representer
      pass :render_json

      def filter_captured_pokemons(ctx, filter:, **)
        case filter
        when 'released'
          ctx[:relation] = CapturedPokemon.filter('deleted').includes(pokemon: %i[region types moves])
        else
          ctx[:relation] = CapturedPokemon.filter(filter).includes(pokemon: %i[region types moves])
        end
      end

      def fetch_captured_pokemons(ctx, current_user:, relation:, trainer_id: nil, **)
        if current_user.doctor_role?
          ctx[:relation] = relation.where(user_id: trainer_id)
        elsif current_user.trainer_role?
          ctx[:relation] = relation.where(user: current_user)
        end
      end

      def set_representer(ctx, **)
        ctx[:representer] = CapturedPokemon::Representers::CapturedPokemon
      end
    end
  end
end

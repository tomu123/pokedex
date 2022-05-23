# frozen_string_literal: true

class User
  module Operations
    class Search < Application::Operations::Search
      pass :fetch_users
      pass :filter_and_sort_relation
      pass Subprocess(Application::Operations::Pagination)
      pass :set_representer
      pass :render_json

      def fetch_users(ctx, filter:, **)
        ctx[:relation] = User.filter(filter).includes(captured_pokemons: { pokemon: %i[region types moves] })
      end

      def set_representer(ctx, **)
        ctx[:representer] = User::Representers::User
      end
    end
  end
end

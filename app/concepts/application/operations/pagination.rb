# frozen_string_literal: true

module Application
  module Operations
    class Pagination < Trailblazer::Operation
      include Pagy::Backend

      pass :paginate

      def paginate(ctx, relation:, items:, page:, **)
        pagy, collection = pagy(relation, items: items || Pagy::DEFAULT[:items], page: page || Pagy::DEFAULT[:page])
        ctx[:pagy] = pagy
        ctx[:collection] = collection
      end
    end
  end
end

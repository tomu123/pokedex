# frozen_string_literal: true

class Region
  module Operations
    class Show < Trailblazer::Operation
      pass :set_region
      pass :render_json

      def set_region(ctx, region_id:, **)
        ctx[:region] = Region.find(region_id)
      end

      def render_json(ctx, region:, **)
        ctx[:json] = Region::Representers::Region.jsonapi_new(region).to_json
      end
    end
  end
end

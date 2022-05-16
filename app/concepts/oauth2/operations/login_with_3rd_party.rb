# frozen_string_literal: true

module Oauth2
  module Operations
    class LoginWith3rdParty < Trailblazer::Operation
      step :select_provider_operation

      def select_provider_operation(ctx, provider:, **)
        case provider
        when 'google'
          Oauth2::Operations::LoginWithGoogle.call(**ctx)
        else
          raise ArgumentError, 'Invalid Third Party Authentication Provider'
        end
      end
    end
  end
end

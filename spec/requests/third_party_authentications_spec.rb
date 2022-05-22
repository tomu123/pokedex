# rubocop:disable Layout/LineLength,Metrics/BlockLength
require 'rails_helper'

RSpec.describe "Third Party Authentication", type: :request do
  let(:client_app) { Doorkeeper::Application.create(name: "Android client", redirect_uri: "", scopes: "") }

  describe "POST /oauth/token" do
    before do
      create_stub(url: ENV.fetch('FACEBOOK_USER_DATA_ENDPOINT'),
                  query: { fields: "id,first_name,last_name,email", access_token: "access_token_ok" },
                  json_response: File.read(Rails.root.join("spec/webmock/facebook_success_response.json")), status: 200)
      create_stub(url: ENV.fetch('FACEBOOK_USER_DATA_ENDPOINT'),
                  query: { fields: "id,first_name,last_name,email", access_token: "access_token_fail" },
                  json_response: File.read(Rails.root.join("spec/webmock/facebook_failure_response.json")), status: 400)
      create_stub(url: ENV.fetch('GOOGLE_USER_DATA_ENDPOINT'),
                  query: { access_token: "access_token_ok" },
                  json_response: File.read(Rails.root.join("spec/webmock/google_success_response.json")), status: 200)
      create_stub(url: ENV.fetch('GOOGLE_USER_DATA_ENDPOINT'),
                  query: { access_token: "access_token_fail" },
                  json_response: File.read(Rails.root.join("spec/webmock/google_failure_response.json")), status: 403)
    end

    it "register a user when this is the first time they login with a third party app, create a token for the user and return it" do
      ['facebook', 'google'].each do |provider|
        expect do
          post oauth_token_path, params: {
            grant_type: "assertion",
            provider: provider,
            access_token: "access_token_ok"
          }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(client_app.uid, client_app.secret) }
        end.to change { User.count }.by(1)
        expect(JSON.parse(response.body)).to include("access_token" => Doorkeeper::AccessToken.last.token)
        expect(response).to have_http_status(200)
      end
    end

    it "find a user when this is not the first time they login with a third party app, create a token for the user and return it" do
      ['facebook', 'google'].each do |provider|
        post oauth_token_path, params: {
          grant_type: "assertion",
          provider: provider,
          access_token: "access_token_ok"
        }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(client_app.uid, client_app.secret) }
        expect do
          post oauth_token_path, params: {
            grant_type: "assertion",
            provider: provider,
            access_token: "access_token_ok"
          }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(client_app.uid, client_app.secret) }
        end.to_not change { User.count }.from(User.count)
        expect(JSON.parse(response.body)).to include("access_token" => Doorkeeper::AccessToken.last.token)
        expect(response).to have_http_status(200)
      end
    end

    it "does not register a user when given an invalid provider, also returns an error with status code 422 Unprocessable Entity" do
      expect do
        post oauth_token_path, params: {
          grant_type: "assertion",
          provider: 'invalid_provider',
          access_token: "access_token_ok"
        }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(client_app.uid, client_app.secret) }
      end.to_not change { User.count }.from(User.count)
      expect(JSON.parse(response.body)).to eq("errors" => {
                                                "title" => "argument_error",
                                                "detail" => "Invalid Third Party Authentication Provider"
                                              })
      expect(response).to have_http_status(422)
    end

    it "returns an error with status code 401 Unauthorized when given invalid client app credentials" do
      ['facebook', 'google'].each do |provider|
        post oauth_token_path, params: {
          grant_type: "assertion",
          provider: provider,
          access_token: "access_token_ok"
        }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(client_app.uid, 'invalid_secret') }
        expect(JSON.parse(response.body)).to eq(
          "error" => "invalid_client",
          "error_description" => "Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method."
        )
        expect(response).to have_http_status(401)
      end
    end

    it "does not register a user and returns an error with status code 401 Unauthorized when given an invalid access token" do
      ['facebook', 'google'].each do |provider|
        expect do
          post oauth_token_path, params: {
            grant_type: "assertion",
            provider: provider,
            access_token: "access_token_fail"
          }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(client_app.uid, client_app.secret) }
        end.to_not change { User.count }.from(User.count)
        expect(JSON.parse(response.body)).to eq("errors" => {
                                                  "title" => "Could not Authenticate",
                                                  "detail" => "Invalid Access Token"
                                                })
        expect(response).to have_http_status(401)
      end
    end
  end
end

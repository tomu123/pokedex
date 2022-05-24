require 'rails_helper'

RSpec.describe "/api/v1/trainer/captured_pokemons", type: :request do
  include_context 'Application'

  let(:representer) { CapturedPokemon::Representers::CapturedPokemon }
  let(:captured_pokemon_attr) { attributes_for(:captured_pokemon, pokemon: create(:pokemon, types: [type])) }

  describe "GET /index" do
    context "with valid access token" do
      it "renders a successful response when there are multiple captured pokemons for the trainer" do
        rand(1..5).times do
          create(:captured_pokemon, user: trainer)
        end
        get api_v1_trainer_captured_pokemons_url, headers: valid_headers_trainer
        expect(response).to have_http_status(200)
        json = representer.jsonapi_for_collection(CapturedPokemon.where(user: trainer)).to_json
        expect(response.body).to include(json[..-2])
      end
      it "renders a successful response when there is one captured pokemons for the trainer" do
        create(:captured_pokemon, user: trainer)
        get api_v1_trainer_captured_pokemons_url, headers: valid_headers_trainer
        expect(response).to have_http_status(200)
        json = representer.jsonapi_for_collection(CapturedPokemon.where(user: trainer)).to_json
        expect(response.body).to include(json[..-2])
      end
      it "renders a successful response when there are not any captured pokemons for the trainer" do
        get api_v1_trainer_captured_pokemons_url, headers: valid_headers_trainer
        expect(response).to have_http_status(200)
        json = representer.jsonapi_for_collection(CapturedPokemon.where(user: trainer)).to_json
        expect(response.body).to include(json[..-2])
      end
    end
    context 'with invalid access token' do
      it "renders an unauthorized response when the user is not a trainer" do
        get api_v1_trainer_captured_pokemons_url, headers: invalid_headers_trainer
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "GET /show" do
    context 'with valid access token' do
      it "renders a successful response" do
        get api_v1_trainer_captured_pokemon_url(captured_pokemon), headers: valid_headers_trainer
        expect(response).to have_http_status(200)
      end
    end
    context 'with invalid access token' do
      it "renders an unauthorized response when the user is not a trainer" do
        get api_v1_trainer_captured_pokemon_url(captured_pokemon), headers: invalid_headers_trainer
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid access token" do
      it "updates the requested captured pokemon stats or name" do
        captured_pokemon
        expect do
          patch api_v1_trainer_captured_pokemon_url(captured_pokemon),
                params: { data: captured_pokemon_attr }.to_json, headers: valid_headers_trainer
          captured_pokemon.reload
        end.to change { captured_pokemon.attributes }.from(captured_pokemon.attributes)
        expect(captured_pokemon.attributes.with_indifferent_access).to include(captured_pokemon_attr)
        expect(response).to have_http_status(:ok)
      end

      it "renders a not_found response when the requested captured pokemon does not exist" do
        captured_pokemon.destroy
        patch api_v1_trainer_captured_pokemon_url(captured_pokemon),
              params: { data: captured_pokemon_attr }.to_json, headers: valid_headers_trainer
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with invalid access token' do
      it "renders an unauthorized response when the user is not a trainer" do
        captured_pokemon
        expect do
          patch api_v1_trainer_captured_pokemon_url(captured_pokemon),
                params: { data: captured_pokemon_attr }.to_json, headers: invalid_headers_trainer
          captured_pokemon.reload
        end.to_not change { captured_pokemon.attributes }.from(captured_pokemon.attributes)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /destroy" do
    context 'with valid access token' do
      it "release the requested captured pokemon" do
        captured_pokemon
        expect do
          delete api_v1_trainer_captured_pokemon_url(captured_pokemon), headers: valid_headers_trainer
        end.to change { CapturedPokemon.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
      it "renders a not_found response when the requested captured pokemon does not exist" do
        captured_pokemon.destroy
        expect do
          delete api_v1_trainer_captured_pokemon_url(captured_pokemon), headers: valid_headers_trainer
        end.to_not change { CapturedPokemon.count }.from(CapturedPokemon.count)
        expect(response).to have_http_status(:not_found)
      end
      it "renders a not_found response when the requested captured pokemon has already been released" do
        captured_pokemon.soft_destroy
        expect do
          delete api_v1_trainer_captured_pokemon_url(captured_pokemon), headers: valid_headers_trainer
        end.to_not change { CapturedPokemon.count }.from(CapturedPokemon.count)
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'with invalid access token' do
      it "renders an unauthorized response when the user is not a trainer" do
        captured_pokemon
        expect do
          delete api_v1_trainer_captured_pokemon_url(captured_pokemon), headers: invalid_headers_trainer
        end.to_not change { CapturedPokemon.count }.from(CapturedPokemon.count)
        expect(response).to have_http_status(401)
      end
    end
  end
end

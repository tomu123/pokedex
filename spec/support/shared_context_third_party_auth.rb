RSpec.shared_context "Third Party Authentication" do
  before do
    create_stub(url: ENV.fetch('FACEBOOK_USER_DATA_ENDPOINT'),
                query: { fields: "id,first_name,last_name,email,picture", access_token: "access_token_ok" },
                json_response: File.read(Rails.root.join("spec/webmock/facebook_success_response.json")), status: 200)
    create_stub(url: ENV.fetch('FACEBOOK_USER_DATA_ENDPOINT'),
                query: { fields: "id,first_name,last_name,email,picture", access_token: "access_token_fail" },
                json_response: File.read(Rails.root.join("spec/webmock/facebook_failure_response.json")), status: 400)
    create_stub(url: ENV.fetch('GOOGLE_USER_DATA_ENDPOINT'),
                query: { access_token: "access_token_ok" },
                json_response: File.read(Rails.root.join("spec/webmock/google_success_response.json")), status: 200)
    create_stub(url: ENV.fetch('GOOGLE_USER_DATA_ENDPOINT'),
                query: { access_token: "access_token_fail" },
                json_response: File.read(Rails.root.join("spec/webmock/google_failure_response.json")), status: 403)
  end
end

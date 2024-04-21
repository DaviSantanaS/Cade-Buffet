require 'rails_helper'
require 'pry'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    let(:response_json) { JSON.parse(response.body) }
    subject { response }
    before do
      get home_index_path
    end
    it 'should return success code 200' do

      is_expected.to have_http_status(200)
    end
    # pending "add some examples (or delete) #{__FILE__}"
  end
end

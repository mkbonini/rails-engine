require 'rails_helper'

RSpec.describe 'The merchants search API' do
  let!(:merchants) { create_list(:merchant, 10) }
  let(:merchant_id) { merchants.first.id }
  let(:merchant_name) { merchants.first.name }

  describe 'get /api/v1/merchants/find' do
    context 'when the name request is valid' do
      before { get "/api/v1/merchants/find?name=#{merchant_name}", params: name=merchant_name }

      it 'finds an merchant' do
        expect(json[:data][:attributes][:name]).to eq(merchant_name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the search request is valid but empty' do
      before { get "/api/v1/merchants/find?name=99999"}

      it 'finds empty data' do
        expect(json[:data]).to eq({})
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the param is blank' do
      before { get "/api/v1/merchants/find?name="}

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'get /api/v1/merchants/find_all' do
    context 'when the name request is valid' do
      before { get "/api/v1/merchants/find_all?name=#{merchant_name}", params: name=merchant_name }

      it 'finds a list of merchants' do
        expect(json[:data].count > 0).to eq(true)
        expect(json[:data].first[:type]).to eq('merchant')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the search request is valid but empty' do
      before { get "/api/v1/merchants/find_all?name=99999"}

      it 'finds empty data' do
        expect(json[:data]).to eq([])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the param is blank' do
      before { get "/api/v1/merchants/find_all?name="}

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
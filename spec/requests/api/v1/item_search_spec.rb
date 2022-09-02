require 'rails_helper'

RSpec.describe 'The items search API' do
  let!(:items) { create_list(:item, 10) }
  let(:item_id) { items.first.id }
  let(:item_name) { items.first.name }
  let(:item_min_price) { items.first.unit_price - 1 }
  let(:item_max_price) { items.first.unit_price + 1 }

  describe 'get /api/v1/items/find' do
    context 'when the name request is valid' do
      before { get "/api/v1/items/find?name=#{item_name}", params: name=item_name }

      it 'finds an item' do
        expect(json[:data][:attributes][:name]).to eq(item_name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the min price request is valid' do
      before { get "/api/v1/items/find?min_price=#{item_min_price}"}

      it 'finds an item' do
        expect(json[:data][:type]).to eq("item")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the max price request is valid' do
      before { get "/api/v1/items/find?max_price=#{item_max_price}"}

      it 'finds an item' do
        expect(json[:data][:type]).to eq("item")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { get "/api/v1/items/find?name=#{item_max_price}"}

      it 'finds an item' do
        expect(json[:data]).to eq({})
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'get /api/v1/items/find_all' do
    context 'when the name request is valid' do
      before { get "/api/v1/items/find_all?name=#{item_name}", params: name=item_name }

      it 'finds a list of items' do
        expect(json[:data].count > 0).to eq(true)
        expect(json[:data].first[:type]).to eq('item')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the min price request is valid' do
      before { get "/api/v1/items/find_all?min_price=#{item_min_price}"}

      it 'finds items' do
        expect(json[:data].count > 0).to eq(true)
        expect(json[:data].first[:type]).to eq("item")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the max price request is valid' do
      before { get "/api/v1/items/find_all?max_price=#{item_max_price}"}

      it 'finds items' do
        expect(json[:data].count > 0).to eq(true)
        expect(json[:data].first[:type]).to eq("item")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the search request is valid but empty' do
      before { get "/api/v1/items/find_all?min_price=99999"}

      it 'finds empty data' do
        expect(json[:data]).to eq([])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { get "/api/v1/items/find_all?name=#{item_max_price}"}

      it 'finds items' do
        expect(json[:data][:type]).to eq("item")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
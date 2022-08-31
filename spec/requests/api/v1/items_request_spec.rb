require 'rails_helper'

RSpec.describe 'The items API' do
  let!(:items) { create_list(:item, 10) }
  let(:item_id) { items.first.id }
  it 'sends a list of items' do
    # create_list(:item, 3)

    get '/api/v1/items'

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    items_response = response_body[:data]

    expect(response).to be_successful
    expect(items_response.count).to eq(10)

    items_response.each do |item|
      expect(item).to have_key(:id)
      # expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)

      expect(item[:attributes]).to_not have_key(:created_at)
    end
  end

  it 'sends a single item by id' do
    # items = create_list(:item, 2)

    get "/api/v1/items/#{item_id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    item = response_body[:data]

    expect(response).to be_successful
    expect(item).to have_key(:id)
    expect(item).to have_key(:attributes)
    expect(item[:attributes][:name]).to eq(items.first.name)
    expect(item[:attributes][:description]).to eq(items.first.description)
    expect(item[:attributes][:unit_price]).to eq(items.first.unit_price)
    expect(item[:attributes][:merchant_id]).to eq(items.first.merchant_id)

    expect(item[:attributes][:name]).to_not eq(items.last.name)
  end

  describe 'POST /api/v1/items' do
    let(:merchant) { create(:merchant) }
    let(:valid_attributes) { { name: 'Pet Rock', description: 'A rock you can pet!', unit_price: 99.99, merchant_id: merchant.id} }

    context 'when the request is valid' do
      before { post '/api/v1/items', params: valid_attributes }

      it 'creates an item' do
        expect(json[:data][:attributes][:name]).to eq('Pet Rock')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/items', params: { name: 'Foobar' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank, Unit price can't be blank, Merchant can't be blank, Merchant must exist/)
      end
    end
  end

  describe 'PUT /items/:id' do
    let(:valid_attributes) { { name: 'Hummingbird' } }

    context 'when the record exists' do
      before { put "/api/v1/items/#{item_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json[:data][:attributes][:name]).to eq('Hummingbird')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'Get /items/:id/merchant' do
    before { get "/api/v1/items/#{item_id}/merchant"}

    it 'returns the items merchants' do
      expect(json).to eq("something")
    end
  end

  describe 'DELETE /item/:id' do
    before { delete "/api/v1/items/#{item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end


end
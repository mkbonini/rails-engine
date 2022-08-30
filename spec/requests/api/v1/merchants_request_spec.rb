require 'rails_helper'

RSpec.describe 'The merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      # expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to_not have_key(:created_at)
    end
  end

  it 'sends a single merchant by id' do
    merchants = create_list(:merchant, 2)

    get "/api/v1/merchants/#{merchants.first.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    merchant = response_body[:data]

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to eq(merchants.first.name)

    expect(merchant[:attributes][:name]).to_not eq(merchants.last.name)
  end

  it 'sends all items for a given merchant id' do
    merchants = create_list(:merchant, 2)
    items = create_list(:item, 3)

    get "/api/v1/merchants/#{merchants.first.id}/items"
  end
end
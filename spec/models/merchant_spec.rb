require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }

  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'class methods' do
    let!(:merchants) { create_list(:merchant, 10) }
    let(:merchant_id) { merchants.first.id }
    let(:merchant_name) { merchants.first.name }

    it 'finds by name' do
      expect(Merchant.find_name(merchant_name).first).to eq(merchants.first)
    end
  end
end
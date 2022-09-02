require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    # it { should have_many(:invoices)}
    # it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'class methods' do
    let!(:items) { create_list(:item, 10) }
    let(:item_id) { items.first.id }
    let(:item_name) { items.first.name }
    let(:item_min_price) { items.first.unit_price - 1 }
    let(:item_max_price) { items.first.unit_price + 1 }

    it 'finds by name' do
      expect(Item.find_name(item_name).first).to eq(items.first)
    end

    it 'finds by min' do
      expect(Item.find_min(item_min_price).first).to be_a Item
    end

    it 'finds by max' do
      expect(Item.find_max(item_max_price).first).to be_a Item
    end

    it 'finds by min max' do
      expect(Item.find_min_max(item_min_price,item_max_price).first).to eq(items.first)
    end
  end
end
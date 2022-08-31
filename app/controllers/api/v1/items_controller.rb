class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create 
    item = Item.create!(item_params)
    json_response(ItemSerializer.new(item), :created)
  end

  def destroy
    @item.destroy
  end

  def update
    @item.update!(item_params)
    json_response(ItemSerializer.new(@item))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
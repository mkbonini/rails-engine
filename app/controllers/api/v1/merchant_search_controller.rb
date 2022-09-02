class Api::V1::MerchantSearchController < ApplicationController
  def index
    if !params.key?(:name) || params[:name] == ''
      json_response( {"error": "Invalid Search"}, :bad_request)
    else
      merchant_list = Merchant.find_name(params[:name])
      merchant_list.empty? ? json_response( { data: [] })  : json_response(MerchantSerializer.new(merchant_list))
    end
  end

  def show
    if !params.key?(:name) || params[:name] == ''
      json_response( {"error": "Invalid Search"}, :bad_request)
    else
      merchant_list = Merchant.find_name(params[:name])
      merchant_list.empty? ? json_response( { data: {} })  : json_response(MerchantSerializer.new(merchant_list.first))
    end
  end
end
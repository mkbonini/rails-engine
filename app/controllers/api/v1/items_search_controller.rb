class Api::V1::ItemsSearchController < ApplicationController
  def index
    # if (!params.key?(:name) && !params.key?(:min_price) && !params.key?(:max_price)) || params[:name] == '' || params[:min_price] == '' || params[:max_price] == ''
    #   json_response( {"error": "Invalid Search"}, :bad_request)
    # elsif params[:name] && params[:min_price].nil? && params[:max_price].nil?
    #   item_list = Item.find_name(params[:name])
    #   item_list.empty? ? json_response( { data: [] })  : json_response(ItemSerializer.new(item_list))
    # elsif params[:min_price].to_i > 0 && params[:max_price].to_i > 0 && params[:name].nil?
    #   item_list = Item.find_min_max(params[:min_price], params[:max_price])
    #   item_list.empty? ? json_response( { data: [] })  : json_response(ItemSerializer.new(item_list)) 
    # elsif params[:min_price] > 0 && params[:name].nil?
    #   item_list = Item.find_min(params[:min_price])
    #   item_list.empty? ? json_response( { data: [] })  : json_response(ItemSerializer.new(item_list))
    # elsif params[:max_price] > 0 && params[:name].nil?
    #   item_list = Item.find_max(params[:max_price])
    #   item_list.empty? ? json_response( { data: [] })  : json_response(ItemSerializer.new(item_list))
    # else
    #   json_response( {"error": "Invalid Search"}, :bad_request)
    # end
    if (!params.key?(:name) && !params.key?(:min_price) && !params.key?(:max_price)) || params[:name] == '' || params[:min_price] == '' || params[:min_price].to_i < 0 || params[:max_price] == '' || params[:max_price].to_i < 0 || (params[:name] && (params[:min_price] || params[:max_price])) || (0 < params[:max_price].to_f && params[:max_price].to_f < params[:min_price].to_f)
      json_response( {"error": "Invalid Search"}, :bad_request)
    else
      list = item_list(params)
      list.empty? ? json_response( { data: [] })  : json_response(ItemSerializer.new(list))
    end
  end

  def show
    # if (!params.key?(:name) && !params.key?(:min_price) && !params.key?(:max_price)) || params[:name] == '' || params[:min_price] == '' || params[:max_price] == ''
    #   json_response( {"error": "Invalid Search"}, :bad_request)
    # elsif params[:name] && params[:min_price].nil? && params[:max_price].nil?
    #   item_list = Item.find_name(params[:name]) 
    #   item_list.empty? ? json_response( { data: {} })  : json_response(ItemSerializer.new(item_list.first))
    # elsif params[:min_price].to_i > 0 && params[:max_price].to_i > 0 && params[:name].nil?
    #   item_list = Item.find_min_max(params[:min_price], params[:max_price])
    #   item_list.empty? ? json_response( { data: {} })  : json_response(ItemSerializer.new(item_list.first)) 
    # elsif params[:min_price].to_i > 0 && params[:name].nil?
    #   item_list = Item.find_min(params[:min_price])
    #   item_list.empty? ? json_response( { data: {} })  : json_response(ItemSerializer.new(item_list.first))
    # elsif params[:max_price].to_i > 0 && params[:name].nil?
    #   item_list = Item.find_max(params[:max_price])
    #   item_list.empty? ? json_response( { data: {} })  : json_response(ItemSerializer.new(item_list.first))
    # else
    #   json_response( {"error": "Invalid Search"}, :bad_request)
    # end
    if (!params.key?(:name) && !params.key?(:min_price) && !params.key?(:max_price)) || params[:name] == '' || params[:min_price] == '' || params[:min_price].to_f < 0 || params[:max_price] == '' || params[:max_price].to_f < 0 || (params[:name] && (params[:min_price] || params[:max_price])) || (0 < params[:max_price].to_f && params[:max_price].to_f < params[:min_price].to_f)
      json_response( {"error": "Invalid Search"}, :bad_request)
    else
      list = item_list(params)
      list.empty? ? json_response( { data: {} })  : json_response(ItemSerializer.new(list.first))
    end
  end
end
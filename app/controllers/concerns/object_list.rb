module ObjectList
  def item_list(params)
    if params[:name]
      Item.find_name(params[:name])
    elsif params[:min_price].to_f > 0 && params[:max_price].to_f > 0
      Item.find_min_max(params[:min_price], params[:max_price])
    elsif params[:min_price].to_f > 0 
      Item.find_min(params[:min_price])
    elsif params[:max_price].to_f > 0
      Item.find_max(params[:max_price])
    else
      []
    end
  end
end
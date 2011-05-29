class InventoriesController < ApplicationController
  def show
    @owned_items = current_user.owned_items.sort_by { |item| item.item.item_type }
  end

  def update
    current_user.update_attributes(params[:user])
    redirect_to inventory_path, :notice => "Equipment Updated"
  end
 
end

